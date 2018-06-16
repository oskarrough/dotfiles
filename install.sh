#! /bin/bash

# Delete existing configuration files
rm ~/.config/fish/config.fish
rm ~/.config/fish/functions/compress.fish
rm ~/.config/fish/functions/extract.fish
rm ~/.config/nvim/init.vim
rm ~/.config/i3/config
rm ~/.vimrc

# Create folders (if they don't exist)
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
mkdir -p ~/.config/i3

# Create symlinks
dotfiles=${PWD}

ln -s $dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s $dotfiles/fish/functions/compress.fish ~/.config/fish/functions/compress.fish
ln -s $dotfiles/fish/functions/extract.fish ~/.config/fish/functions/extract.fish
ln -s $dotfiles/.vimrc ~/.vimrc
ln -s $dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s $dotfiles/i3/config ~/.config/i3/config

echo 'Symlinks have been created.'
