" Oskars vim config


" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'andreypopp/vim-colors-plain'
call plug#end()

syntax enable
colorscheme plain

set number
set relativenumber 
set incsearch

" Better autocomplete?
" set path+=**
" set wildmenu

" Configure indentation to tabs
set shiftwidth=2
set tabstop=2

" Use semi-colon to enter command mode because it's one less key
nmap ; :

" Use space as leader (instead of backslash). Set this before other bindings.
let mapleader = "\<Space>"

" Note, the :Ag command comes from fzf.vim
nmap <leader>p :Files<CR>
nmap <leader>gf :GitFiles<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>a :Ag<CR> 
