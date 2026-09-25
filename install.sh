#!/bin/bash

# Exit on errors
set -e

# Dropbox sits at a different path per machine: never hardcode DOTFILES (resolve it here) and re-run to repoint symlinks.
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Keep output scannable: render $HOME as ~. (case form: bash 5.3's ${1/#pat/rep} is broken)
short() { case "$1" in "$HOME"|"$HOME"/*) printf '~%s' "${1#"$HOME"}";; *) printf '%s' "$1";; esac; }

# Colour only when writing to a terminal.
if [[ -t 1 ]]; then
    BOLD=$'\033[1m'
    RED=$'\033[31m'; GREEN=$'\033[32m'; CYAN=$'\033[36m'; RESET=$'\033[0m'
else
    BOLD=; RED=; GREEN=; CYAN=; RESET=
fi

# Unified diff of live ($2) vs repo ($1): '- live', '+ repo', labelled and coloured.
render_diff() {
    diff -u -L "live: $(short "$2")" -L "repo: $(short "$1")" "$2" "$1" | sed -E \
        -e "s/^(---|\+\+\+).*/${BOLD}&${RESET}/" \
        -e "s/^@@.*/${CYAN}&${RESET}/" \
        -e "s/^\+[^+].*/${GREEN}&${RESET}/" \
        -e "s/^-[^-].*/${RED}&${RESET}/"
}

# Source paths are relative to $DOTFILES; targets are absolute.
LINKS=(
    "aerospace/aerospace.toml:$HOME/.config/aerospace/aerospace.toml"
    "fish/config.fish:$HOME/.config/fish/config.fish"
    "fish/functions/bb.fish:$HOME/.config/fish/functions/bb.fish"
    "git/.gitconfig:$HOME/.gitconfig"
    "herdr/config.toml:$HOME/.config/herdr/config.toml"
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
    "bb/theme/oskar/theme.css:$HOME/.bb/theme/oskar/theme.css"
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
        echo "skip: $relative_source (target dir unavailable: $(short "$(dirname "$destination")"))"
        return
    fi

    rm -f "$temporary"
    ln -s "$source" "$temporary"

    # Existing real file that differs from ours: show it, require confirmation.
    if [[ -f "$destination" && ! -L "$destination" ]] && ! cmp -s "$source" "$destination"; then
        printf '\n%s\n' "${BOLD}── $relative_source differs from $(short "$destination")${RESET}"
        render_diff "$source" "$destination"
        printf '\n  replace %s? [y/N] ' "$(short "$destination")"
        read -r reply || reply=""
        printf '\n'
        if [[ ! "$reply" =~ ^[Yy]$ ]]; then
            rm -f "$temporary"
            echo "skip: $relative_source (kept existing file)"
            return
        fi
    fi

    if [[ -L "$destination" ]]; then
        old_target="$(readlink "$destination")"
        rm "$destination"
    elif [[ -e "$destination" ]]; then
        if cmp -s "$source" "$destination"; then
            rm "$destination"
        else
            backup="$(next_backup_path "$destination")"
            mv "$destination" "$backup"
            echo "backup: $(short "$destination") -> $(short "$backup")"
        fi
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

    echo "link: $relative_source -> $(short "$destination")"
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
