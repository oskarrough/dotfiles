" Oskars neovim config

" ===========================
" Plugins
" ===========================
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring' " proper comments for <script> tags etc.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sgur/vim-editorconfig'
Plug 'sheerun/vim-polyglot' " syntax highlighting for everything
Plug 'tpope/vim-surround'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive' " git stuff
Plug 'tpope/vim-vinegar' " nicer (netrw) file browser
Plug 'w0rp/ale' " linter
" Plug 'brooth/far.vim' " search/replace

" Plugins for neovim only
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Plugins for appearance
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'nanotech/jellybeans.vim'
" Plug 'vim-scripts/ScrollColors'
Plug 'rakr/vim-one'
" Plug 'morhetz/gruvbox'
" Plug 'w0ng/vim-hybrid'
call plug#end()

" ===========================
" Settings
" ===========================

set background=dark
colorscheme jellybeans
set clipboard+=unnamedplus " Always copy to system clipboard
set cursorline " Highlight the current line
set hidden " Allow buffer switching even if unsaved
set number " Show line numbers
set noswapfile " Disable creating *.swp files
set relativenumber " Use relative line numbers
set scrolloff=2 " Start scrolling X lines before top/end

" Make new splits open towards right and bottom (by default it is the opposite)
set splitright
set splitbelow

" Configure indentation to use tabs instead of spaces
set noexpandtab
set shiftwidth=2
set tabstop=2

" Search
set ignorecase " case-insensitive searching
set smartcase " but become case-sensitive if you type uppercase

" ===========================
" KEYBINDINGS
" ===========================

" Use space as leader (instead of backslash) 
let mapleader = "\<Space>"

" Use semi-colon to enter command mode because it's one less key
nmap ; :

" Quickly edit and reload/source the config.
nmap <silent> <leader>ev :edit $MYVIMRC<CR>
nmap <silent> <leader>es :so $MYVIMRC<CR>

" toggle between buffers
nnoremap <leader><leader> <c-^>

" instead of ctrl-w then j, it’s just ctrl-j:
noremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Shortcut to save (write) a file
nmap <leader>w :w<CR>

" Shortcut to run prettier
nmap <Leader>f <Plug>(Prettier)

" Move by line
nnoremap j gj
nnoremap k gk

" ===========================
" Plugin config
" ===========================

" Specify where python3 is
if has('mac')
	let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('unix')
	let g:python3_host_prog = '/usr/bin/python3'
endif

" Map <space-p> to switch files
" Note, the :Ag command comes from fzf.vim
let g:fzf_layout = { 'down': '~40%' }
nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>a :Ag<CR> 
nmap <leader>gf :GitFiles<CR>
" imap <c-x><c-l> <plug>(fzf-complete-line)

" no idea what this is
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


" Deoplate config.
let g:deoplete#enable_at_startup = 1
" Use tab to complete.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" When lightline is enabled, we can hide the default status indicator
set noshowmode

let g:lightline = {
	\ 'colorsheme': 'jellybeans',
	\ }

