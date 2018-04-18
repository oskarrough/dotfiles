" PLUGINS 
call plug#begin('~/.vim/plugged')
Plug 'brooth/far.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" PLUGINS: Syntax
Plug 'w0rp/ale'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-editors/vim-elixir'
Plug 'hail2u/vim-css3-syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'slashmili/alchemist.vim'
" Plug 'lambdatoast/elm.vim'
" Plug 'rakr/vim-one'
call plug#end()

let g:ale_linters = {
\   'javascript': ['prettier'],
\}

" APPEARANCE

set termguicolors " True color support
colorscheme jellybeans
" set background=light
" let g:airline_theme='one' " Use `one` for vim-airline as well
" colorscheme one

" Make new splits open towards right and bottom (by default it is the opposite)
set splitright
set splitbelow

" instead of ctrl-w then j, it’s just ctrl-j:
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use tabs 
set noexpandtab
" And set tab-size
set shiftwidth=2
set tabstop=2

" Search
set gdefault " Search entire file by default (as opposed to line)
set ignorecase " case-insensitive searching
set smartcase " but become case-sensitive if you type uppercase

set clipboard+=unnamedplus " Always copy to system clipboard
set cursorline " Highlight the current line
set hidden " Allow buffer switching even if unsaved
set number " Show line numbers
set noswapfile " Disable creating *.swp files
set relativenumber " Use relative line numbers


" AUTOCOMPLETE: with deoplete and use the tab-key
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" KEYBINDINGS

" Use space as leader (instead of backslash). Set this before other bindings.
let mapleader = "\<Space>"

" Because leaving insert mode should be easy. Just kidding.
imap jk <ESC>

" Map <space-p> to switch files
" nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>gf :GitFiles<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

" Note, the :Ag command comes from fzf.vim
nmap <leader>a :Ag

" Shortcut to save (write) a file
" nmap <leader>w :w<CR>
nmap <leader>s :w<CR>

" Use ; to enter command mode (one less key)
nmap ; :

" Maps the <space-ev> and <space-sv> keys to edit/reload the vim config
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>es :so $MYVIMRC<CR>

" Shortcut to run prettier
nmap <Leader>f <Plug>(Prettier)

" Specify where python3 is
if has('mac')
	let g:python3_host_prog = '/usr/local/bin/python3'
else
	let g:python3_host_prog = '/usr/bin/python3'
endif

" Set *.vue files to open as html. Makes for nicer rendering.
" autocmd BufNewFile,BufRead *.vue set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html
