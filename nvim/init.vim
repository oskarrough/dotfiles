" PLUGINS

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
" Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'lambdatoast/elm.vim'
Plug 'hail2u/vim-css3-syntax'
" Plug 'zefei/vim-colortuner'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'w0ng/vim-hybrid'
Plug 'rakr/vim-one'
" Plug 'neomake/neomake'
call plug#end()

" APPEARANCE

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=light
colorscheme one
let g:airline_theme='one'
" set background=dark
" colorscheme hybrid
" let g:hybrid_custom_term_colors=1
" Highlight the current line
set cursorline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
" Enable powerline fonts
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" SETTINGS

set clipboard+=unnamedplus " Always copy to system clipboard
set number " show line numbers
set relativenumber " use relative line numbers
set scrolloff=6 " start scrolling three lines earlier

" Make new splits open towards right and bottom (normally it's inversed)
set splitright
set splitbelow

" Use tabs with a width of two spaces
set noexpandtab
set shiftwidth=2
set tabstop=2

set noswapfile " disable creating *.swp files
set gdefault " search entire file by default (as opposed to line)

" KEYBINDINGS

" Use space as leader (instead of the default "\")
let mapleader = "\<Space>"

" Map <space-p> to switch files
" nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :History<CR>
nmap <leader>gf :GitFiles<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"
" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Quick way to save file
" nmap <leader>w :w<CR>
nmap <leader>s :w<CR>

" Use ; for commands
nmap ; :

" Make the tab key match bracket pairs.
nmap <tab> %
vmap <tab> %

" Maps the <space-ev> and <space-sv> keys to edit/reload the vim config
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>es :sv $MYVIMRC<CR>

" Specify where python3 is
let g:python3_host_prog = '/usr/bin/python3'

" Enable deoplete plugin
" let g:deoplete#enable_at_startup = 1

" <C-h>, <BS>: close popup and delete backword char.
" imap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" imap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" " <CR>: close popup and save indent.
" imap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"     return deoplete#close_popup() . "\<CR>"
" endfunction

" deoplete auto close
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
" imap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" " tern
" autocmd FileType javascript nmap <silent> <buffer> gb :TernDef<CR>
