#!/bin/bash

# Exit on errors
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Source paths are relative to $DOTFILES; targets are absolute.
LINKS=(
    "aerospace/aerospace.toml:$HOME/.config/aerospace/aerospace.toml"
    "fish/config.fish:$HOME/.config/fish/config.fish"
    "git/.gitconfig:$HOME/.gitconfig"
    "hypr/hyprland.lua:$HOME/.config/hypr/hyprland.lua"
    "kitty/kitty.conf:$HOME/.config/kitty/kitty.conf"
    "kitty/current-theme.conf:$HOME/.config/kitty/current-theme.conf"
    "nvim/init.lua:$HOME/.config/nvim/init.lua"
    "tmux/tmux.conf:$HOME/.tmux.conf"
    "vim/.vimrc:$HOME/.vimrc"
    "emacs/init.el:$HOME/.config/emacs/init.el"
    "waybar/config.jsonc:$HOME/.config/waybar/config.jsonc"
    "waybar/style.css:$HOME/.config/waybar/style.css"
    "jj/config.toml:$HOME/.config/jj/config.toml"
    "omp/config.yml:$HOME/.omp/agent/config.yml"
)

# Add Windows configs only when WSL can resolve the Windows user profile.
if [[ -n "${WSL_DISTRO_NAME:-}" ]] && command -v powershell.exe >/dev/null 2>&1 && command -v wslpath >/dev/null 2>&1; then
    if windows_profile_win="$(powershell.exe -NoProfile -Command '[Environment]::GetFolderPath("UserProfile")' 2>/dev/null)"; then
        windows_profile_win="${windows_profile_win//$'\r'/}"
        windows_profile="$(wslpath "$windows_profile_win")"
        LINKS+=(
            "komorebi/komorebi.json:$windows_profile/.config/komorebi/komorebi.json"
            "komorebi/komorebi.bar.json:$windows_profile/.config/komorebi/komorebi.bar.json"
            "whkdrc:$windows_profile/.config/whkdrc"
        )
    else
        echo "skip: Windows configs (could not resolve Windows profile)"
    fi
fi

next_backup_path() {
    local destination="$1"
    local backup="${destination}.bak"
    local number=1

    while [[ -e "$backup" || -L "$backup" ]]; do
        backup="${destination}.bak.${number}"
        ((number += 1))
    done

    printf '%s\n' "$backup"
}

link_config() {
    local relative_source="$1"
    local destination="$2"
    local source="$DOTFILES/$relative_source"
    local temporary="${destination}.dotfiles.$$"
    local backup=""
    local old_target=""

    if [[ ! -e "$source" ]]; then
        echo "skip: $relative_source (not found)"
        return
    fi

    if ! mkdir -p "$(dirname "$destination")" 2>/dev/null; then
        echo "skip: $relative_source (target dir unavailable: $(dirname "$destination"))"
        return
    fi

    rm -f "$temporary"
    ln -s "$source" "$temporary"

    if [[ -L "$destination" ]]; then
        old_target="$(readlink "$destination")"
        rm "$destination"
    elif [[ -e "$destination" ]]; then
        backup="$(next_backup_path "$destination")"
        mv "$destination" "$backup"
        echo "backup: $destination -> $backup"
    fi

    if ! mv "$temporary" "$destination"; then
        rm -f "$temporary"
        if [[ -n "$backup" ]]; then
            mv "$backup" "$destination"
        elif [[ -n "$old_target" ]]; then
            ln -s "$old_target" "$destination"
        fi
        return 1
    fi

    echo "link: $relative_source -> $destination"
}

for link in "${LINKS[@]}"; do
    link_config "${link%%:*}" "${link#*:}"
done

# Restore GNOME keybindings when dconf is available.
if command -v dconf &> /dev/null; then
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$DOTFILES/gnome/gnome-media-keys.dconf"
    dconf load /org/gnome/desktop/wm/keybindings/ < "$DOTFILES/gnome/gnome-wm-keys.dconf"
    echo "dconf: GNOME keybindings restored"
fi

echo "done."
