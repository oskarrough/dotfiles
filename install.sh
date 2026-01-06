#!/bin/bash

# Exit on errors
set -e

# Gets the folder path of the install script (in case it is run outside the dir)
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Define symlinks: "source:target" pairs. Source is relative to $DOTFILES, target is absolute
LINKS=(
    "fish/config.fish:$HOME/.config/fish/config.fish"
    "git/.gitconfig:$HOME/.gitconfig"
    "git/.gitignore:$HOME/.gitignore"
    "hypr/hyprland.conf:$HOME/.config/hypr/hyprland.conf"
    "i3/config:$HOME/.config/i3/config"
    "kitty/kitty.conf:$HOME/.config/kitty/kitty.conf"
    "nvim/init.lua:$HOME/.config/nvim/init.lua"
    "tmux/tmux.conf:$HOME/.tmux.conf"
    "vim/.vimrc:$HOME/.vimrc"
)

# Create symlinks
for link in "${LINKS[@]}"; do
    src="${link%%:*}"
    dst="${link#*:}"

    # Skip if source doesn't exist
    [[ ! -e "$DOTFILES/$src" ]] && echo "skip: $src (not found)" && continue

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    # Remove existing file/symlink
    rm -f "$dst"

    # Create symlink
    ln -s "$DOTFILES/$src" "$dst"
    echo "link: $src -> $dst"
done

# Restore GNOME keybindings (if dconf available)
if command -v dconf &> /dev/null; then
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$DOTFILES/gnome/gnome-media-keys.dconf"
    dconf load /org/gnome/desktop/wm/keybindings/ < "$DOTFILES/gnome/gnome-wm-keys.dconf"
    echo "dconf: GNOME keybindings restored"
fi

echo "done."
