" Minimal Vim fallback for machines without Neovim.
set noswapfile
syntax enable

set number
set relativenumber
set incsearch
set hidden
set shiftwidth=2
set tabstop=2
set encoding=utf-8
set clipboard=unnamed

" Use space as leader.
let mapleader = "\<Space>"

" Use semicolon to enter command mode.
nmap ; :

" Save.
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Buffers.
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
