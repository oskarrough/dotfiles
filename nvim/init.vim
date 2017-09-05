" PLUGINS: General

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-vinegar'
Plug 'editorconfig/editorconfig-vim'
" let g:EditorConfig_core_mode = 'external_command'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
" Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'brooth/far.vim'

" PLUGINS: Appearances

Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
" Plug 'zefei/vim-colortuner'

" PLUGINS: Syntax

" Plug 'othree/html5.vim'
" Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'posva/vim-vue'
" Plug 'elixir-lang/vim-elixir'
" Plug 'leafgarland/typescript-vim'
Plug 'digitaltoad/vim-pug'
" Plug 'lambdatoast/elm.vim'
call plug#end()

" let g:ale_linters = {
" \   'javascript': ['xo'],
" \}
" let g:ale_sign_error = '!!'

" APPEARANCE

" set termguicolors " True color support
" set background=light " The `one` theme also supports "dark"
" let g:airline_theme='one' " Use `one` for vim-airline as well
let g:one_allow_italics = 1
colorscheme one

" Make NETRW a bit nicer
"http://vimcasts.org/episodes/the-file-explorer/
let g:netrw_banner = 0 " hides the banner
let g:netrw_liststyle = 3 " tree-view
" let g:netrw_browse_split = 4 " open in previous window
" let g:netrw_winsize = -30 " percentage width of netrw window
" let g:netrw_altv = 1

" Show list of buffers and which branch
let g:airline#extensions#tabline#enabled = 1 " Show all buffers when there's only one tab open
" let g:airline#extensions#branch#enabled = 1 " Not sure what this is

" Enable powerline fonts
" let g:airline_powerline_fonts=1
" if !exists('g:airline_symbols')
" 	let g:airline_symbols = {}
" endif

" Enable deoplete plugin
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" GENERAL SETTINGS

" Make new splits open towards right and bottom (by default it is the opposite)
set splitright
set splitbelow

" Use tabs with a width of X spaces
set noexpandtab
set shiftwidth=2
set tabstop=2

" Searching
set gdefault " Search entire file by default (as opposed to line)
set ignorecase " case-insensitive searching
set smartcase " but become case-sensitive if you type uppercase
set inccommand=split " neovim 2.0 feature. live preview when using :%s/foo/bar

set clipboard+=unnamedplus " Always copy to system clipboard
set cursorline " Highlight the current line
set hidden " Allow buffer switching even if unsaved
set number " Show line numbers
set noswapfile " Disable creating *.swp files
set relativenumber " Use relative line numbers
" set scrolloff=4 " Start scrolling three lines earlier

" KEYBINDINGS

" Use space as leader (instead of backslash). Set this before other
" bindings.
let mapleader = "\<Space>"

" Because leaving insert mode should be easy
imap jk <ESC>

" Map <space-p> to switch files
" nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>gf :GitFiles<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader>a :Ag

" Shortcut to save (write) a file
" nmap <leader>w :w<CR>
nmap <leader>s :w<CR>

" Use ; to enter command mode (one less key)
nmap ; :

" Make the tab key match bracket pairs in normal+visual mode.
" nmap <tab> %
" vmap <tab> %

" Maps the <space-ev> and <space-sv> keys to edit/reload the vim config
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>es :so $MYVIMRC<CR>

" Specify where python3 is
" let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

" Set *.vue files to open as html. Makes for nicer rendering.
" autocmd BufNewFile,BufRead *.vue set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html
