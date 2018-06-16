" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'lifepillar/vim-cheat40'
call plug#end()

" Enable FZF via Homebrew
set rtp+=/usr/local/opt/fzf

" Enable syntax highlighting
syntax enable

" Use relative numbering
set relativenumber 
" And show current line-number
set number

" Configure indentation to tabs
set shiftwidth=2
set tabstop=2

" Use semi-colon to enter command mode because it's one less key
nmap ; :

" Use space as leader (instead of backslash). Set this before other bindings.
let mapleader = "\<Space>"

" Because leaving insert mode should be easy. Just kidding.
imap jk <ESC>

