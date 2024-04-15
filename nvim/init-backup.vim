" Oskars neovim config

" ===========================
" Plugins
" ===========================
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sgur/vim-editorconfig'
Plug 'sheerun/vim-polyglot' " syntax highlighting for everything
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' " git stuff
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'w0rp/ale' " linter
" Plug 'suy/vim-context-commentstring' " proper comments for <script> tags etc.
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'brooth/far.vim' " search/replace

" Plugins for appearance
" Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
" Plug 'catppuccin/nvim', {'as': 'catppuccin'}
" Plug 'chriskempson/base16-vim'
" Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale'
" Plug 'rakr/vim-one'
" Plug 'w0ng/vim-hybrid'
" Plug 'vim-scripts/ScrollColors'
call plug#end()

" ===========================
" Settings
" ===========================

" set termguicolors
" colorscheme base16-default-dark
set background=light
" colorscheme one
colorscheme jellybeans
" colorscheme gruvbox
" let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
" lua << 
" require("catppuccin").setup()
" colorscheme catppuccin

set clipboard+=unnamedplus " Always copy to system clipboard
" set cursorline " Highlight the current line
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
" nmap ; :

" Quickly edit and reload/source the config.
nmap <silent> <leader>ev :edit $MYVIMRC<CR>
nmap <silent> <leader>es :so $MYVIMRC<CR>

" toggle between buffers
nnoremap <leader><leader> <c-^>

" instead of ctrl-w then j, it’s just ctrl-j:
" noremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Shortcut to save (write) a file
" nmap <leader>w :w<CR>

" Shortcut to run prettier
nmap <Leader>f <Plug>(Prettier)

" Move by line
" nnoremap j gj
" nnoremap k gk

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
" nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
" nmap <leader>b :ls<CR>
" nnoremap <leader>b :ls<cr>:b<space>
nmap <leader>h :History<CR>
nmap <leader>a :Ag<CR> 
nmap <leader>gf :GitFiles<CR>
nmap <leader>w :w<CR>
" imap <c-x><c-l> <plug>(fzf-complete-line)

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

