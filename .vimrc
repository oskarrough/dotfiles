" Oskars vim config
set noswapfile

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'andreypopp/vim-colors-plain'
Plug 'sgur/vim-editorconfig'
Plug 'prettier/vim-prettier'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
call plug#end()

" Colors
syntax enable
colorscheme plain
set bg=light

" overwrite line number color
highlight LineNr ctermfg=252
highlight CursorLineNr ctermfg=16

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
nmap <leader>a :Ag<CR> 
nmap <leader>f <Plug>(Prettier)

" https://github.com/neoclide/coc.nvim
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

nmap <silent> gd <Plug>(coc-definition)

	" let g:fzf_layout = { "window": "silent botright 16split enew" }
