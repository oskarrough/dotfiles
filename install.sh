#! /bin/bash

# Delete existing configuration files
rm ~/.vimrc
rm ~/.config/fish/config.fish
rm ~/.config/nvim/init.vim
rm ~/.emacs.d

# Create folders (if they don't exist)
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
mkdir -p ~/.emacs.d

# Create symlinks
dotfiles=${PWD}

ln -s $dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s $dotfiles/.vimrc ~/.vimrc
ln -s $dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s $dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -s $dotfiles/.emacs.d ~/.emacs.d

echo 'Symlinks have been created.'
