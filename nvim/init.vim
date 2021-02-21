" Oskars neovim config

" ===========================
" Plugins
" ===========================
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
" Plug 'suy/vim-context-commentstring' " proper comments for <script> tags etc.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sgur/vim-editorconfig'
Plug 'sheerun/vim-polyglot' " syntax highlighting for everything
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' " git stuff
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'w0rp/ale' " linter
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'brooth/far.vim' " search/replace

" Plugins for appearance
Plug 'nanotech/jellybeans.vim'
" Plug 'chriskempson/base16-vim'
" Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale'
" Plug 'rakr/vim-one'
" Plug 'morhetz/gruvbox'
" Plug 'w0ng/vim-hybrid'
" Plug 'vim-scripts/ScrollColors'
call plug#end()

" ===========================
" Settings
" ===========================

set termguicolors
" colorscheme base16-default-dark
" set background=light
" colorscheme one
colorscheme jellybeans
set clipboard+=unnamedplus " Always copy to system clipboard
set cursorline " Highlight the current line
set hidden " Allow buffer switching even if unsaved
set number " Show line numbers
set noswapfile " Disable creating *.swp files
set relativenumber " Use relative line numbers
set scrolloff=2 " Start scrolling X lines before top/end
set incsearch

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

" Note, the :Ag command comes from fzf.vim
nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
" nmap <leader>b :ls<CR>
" nnoremap <leader>b :ls<cr>:b<space>
nmap <leader>h :History<CR>
nmap <leader>a :Ag<CR> 
nmap <leader>gf :GitFiles<CR>
" imap <c-x><c-l> <plug>(fzf-complete-line)

" this is some enhanced line autocomplete
" inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
"   \ 'prefix': '^.*$',
"   \ 'source': 'rg -n ^ --color always',
"   \ 'options': '--ansi --delimiter : --nth 3..',
"   \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


" Deoplate config.
" let g:deoplete#enable_at_startup = 1
" Configure deoplete to use tab
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" When lightline is enabled, we can hide the default status indicator
" set noshowmode
" let g:lightline = {
"       \ 'colorscheme': 'jellybeans',
" 	\ 'active': {
" 	\   'left': [ [ 'mode', 'paste' ],
" 	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
" 	\ },
" 	\ 'component_function': {
" 	\   'cocstatus': 'coc#status'
" 	\ },
" 	\ }

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
