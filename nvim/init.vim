" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-sleuth'
call plug#end()

" Colors
colorscheme torte

" Show line numbers and use relative numbers
set number
set relativenumber

" Start scrolling three lines earlier
set scrolloff=3

" Use tabs with a width of two spaces
set noexpandtab
set shiftwidth=2
set tabstop=2

" Use space as leader (instead of \)
let mapleader = "\<Space>"

" Map <space-p> to switch files
nnoremap <silent> <leader>p :Files<CR>

" Quick way to save file
nnoremap <leader>w :w<CR>

" Use ; for commands
nnoremap ; :

" Maps the ,ev and ,sv keys to edit/reload the vim config
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :sv $MYVIMRC<CR>
