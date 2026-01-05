#! /bin/bash

# Delete existing configuration files
rm -f ~/.config/fish/config.fish
rm -f ~/.config/nvim/init.lua
rm -f ~/.config/i3/config
rm -f ~/.tmux.conf

# Create folders (if they don't exist)
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
mkdir -p ~/.config/i3

# Create symlinks
dotfiles=${PWD}

ln -s $dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s $dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -s $dotfiles/i3/config ~/.config/i3/config
ln -s $dotfiles/tmux.conf ~/.tmux.conf

# Restore GNOME keybindings (if on GNOME)
if command -v dconf &> /dev/null; then
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < $dotfiles/gnome-media-keys.dconf
    dconf load /org/gnome/desktop/wm/keybindings/ < $dotfiles/gnome-wm-keys.dconf
    echo 'GNOME keybindings restored.'
fi

echo 'Symlinks have been created.'
