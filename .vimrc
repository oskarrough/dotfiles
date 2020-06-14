" Oskars vim config
set noswapfile

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot' 
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'andreypopp/vim-colors-plain'
Plug 'sgur/vim-editorconfig'
Plug 'rakr/vim-one'
Plug 'nanotech/jellybeans.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

" Colors
syntax enable
" set bg=light
" colorscheme one
" colorscheme plain
colorscheme jellybeans

" overwrite line number color
" highlight LineNr ctermfg=252
" highlight CursorLineNr ctermfg=16

" Settings
set number
set relativenumber 
set incsearch " highlight search results
set hidden " allow switching from unsaved files
set shiftwidth=2 " tabs with a width of 2
set tabstop=2
set encoding=utf-8
set clipboard=unnamed

" Use space as leader (instead of backslash)
let mapleader = "\<Space>"

" Use semi-colon to enter command mode because it's one less key
nmap ; :

" Better autocomplete?
" set path+=**
" set wildmenu
"
" FZF commands
nmap <leader>p :Files<CR>
nmap <leader>gf :GitFiles<CR>
nmap <leader>b :Buffers<CR>
" nmap <leader>a :Ag<CR>  " Using the_silver_searcher
nmap <leader>a :Rg<CR> " Using ripgrep
nmap <leader>f <Plug>(Prettier)

" https://github.com/neoclide/coc.nvim
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
