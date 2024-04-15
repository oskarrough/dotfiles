-- new one?!

local paq = require("paq")

require "paq" {
    "savq/paq-nvim"; -- Let Paq manage itself

     -- Colors and syntax highlighting
    'sheerun/vim-polyglot';
    'evanleck/vim-svelte';
    'morhetz/gruvbox';
    'nanotech/jellybeans.vim';
    -- 'projekt0n/github-nvim-theme';
    -- 'wuelnerdotexe/vim-astro';
}

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

require('lualine').setup {}
require('which-key').setup {}

vim.cmd [[
let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
let g:svelte_preprocessors = ['ts']
]]

vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
-- " Configure indentation to use tabs instead of spaces
vim.opt.expandtab = true
vim.opt.timeoutlen = 500

vim.opt.clipboard = 'unnamedplus' --" Always copy to system clipboard
-- set hidden " Allow buffer switching even if unsaved
-- set noswapfile " Disable creating *.swp files
-- set scrolloff=2 " Start scrolling X lines before top/end

-- " Make new splits open towards right and bottom (by default it is the opposite)
-- set splitright
-- set splitbelow

-- " Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
-- set ignorecase " case-insensitive searching
-- set smartcase " but become case-sensitive if you type uppercase
-- set incsearch

-- COLORS
vim.opt.termguicolors = true
-- vim.o.termguicolors = true
vim.cmd('colorscheme jellybeans')
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd [[silent! colorscheme jellybeans]]
-- vim.cmd('set background=dark')
-- require('github-theme').setup()

vim.g.mapleader = ' ' -- <space> as leader
vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>p', '<cmd>Files<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>')
vim.keymap.set('n', '<leader>a', '<cmd>Ag<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>')

vim.keymap.set('n', '<leader>f', '<cmd>:Prettier<cr>')

--" Quickly edit and reload/source the config.
vim.keymap.set('n', '<leader>ev', '<cmd>:edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>es', '<cmd>:so $MYVIMRC<cr>')

-- When moving up and down center it as well
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')



-- " Note, the :Ag command comes from fzf.vim
-- nmap <leader>a :Ag<CR> 
-- nmap <leader>p :Files<CR>
-- nmap <leader>b :Buffers<CR>
-- " nmap <leader>b :ls<CR>
-- " nnoremap <leader>b :ls<cr>:b<space>
-- nmap <leader>h :History<CR>
-- nmap <leader>gf :GitFiles<CR>
-- " imap <c-x><c-l> <plug>(fzf-complete-line)

--[[
" ===========================
" KEYBINDINGS
" ===========================

" Use semi-colon to enter command mode because it's one less key
" nmap ; :

" toggle between buffers
nnoremap <leader><leader> <c-^>

" instead of ctrl-w then j, it’s just ctrl-j:
" noremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Move by line
" nnoremap j gj
" nnoremap k gk

" nmap <silent> <leader>p :GFiles<CR>
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
" nmap <leader>b :ls<CR>
" nnoremap <leader>b :ls<cr>:b<space>
nmap <leader>h :History<CR>
nmap <leader>gf :GitFiles<CR>
" imap <c-x><c-l> <plug>(fzf-complete-line)

" this is some enhanced line autocomplete
" inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
"   \ 'prefix': '^.*$',
"   \ 'source': 'rg -n ^ --color always',
"   \ 'options': '--ansi --delimiter : --nth 3..',
"   \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

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
"

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

]]--

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)
