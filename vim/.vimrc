" Oskars vim config. Only used when neovim isn't available.
set noswapfile

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
# Plug 'tpope/vim-fugitive'
Plug 'sgur/vim-editorconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'nanotech/jellybeans.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'rakr/vim-one'
Plug 'reedes/vim-colors-pencil'
Plug 'andreypopp/vim-colors-plain'
Plug 'cormacrelf/vim-colors-github'
call plug#end()

" Colors
syntax enable
" set bg=light
" colorscheme one
" colorscheme plain
" colorscheme github
" colorscheme jellybeans

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

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" FZF commands
nmap <leader>p :Files<CR>
nmap <leader>gf :GitFiles<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>a :Ag<CR>
" nmap <leader>a :Rg<CR>
nmap <leader>f <Plug>(Prettier)

" Settings for https://github.com/neoclide/coc.nvim
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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
