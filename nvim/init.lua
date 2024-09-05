-- set mapleader before lazy
vim.g.mapleader = ' ' -- <space> as leader

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.cursorline = true

-- Indention
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Make new splits open towards right and bottom (by default it is the opposite)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set highlight on search, but clear on ESC
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.incsearch = true
vim.opt.inccommand = 'split' -- preview substitions live
vim.opt.ignorecase = true -- case-insensitive searching
vim.opt.smartcase = true  -- but become case-sensitive if you type uppercase

-- To be documented
vim.opt.updatetime = 250 -- cool people do it
vim.opt.timeoutlen = 500
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'yes'
-- set hidden " Allow buffer switching even if unsaved
vim.opt.scrolloff = 3 -- Start scrolling X lines before top/end

-- Colors
vim.opt.termguicolors = true

-- Navigation
vim.keymap.set('n', '<space>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>p', '<cmd>Files<cr>') -- or GitFiles
vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>')
vim.keymap.set('n', '<leader>a', '<cmd>Ag<cr>')    -- from fzf.vim
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>')
vim.keymap.set('i', '<c-x><c-l>', '<plug>(fzf-complete-line)')
-- nmap <leader>h :History<CR>

-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<leader>f', '<cmd>:Prettier<cr>')
vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format()
end)

-- When moving up and down center it as well
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--" Quickly edit and reload/source the config.
vim.keymap.set('n', '<leader>ev', '<cmd>:edit $MYVIMRC<cr>')


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use semi-colon to enter command mode because it's one less key
-- nmap ; :

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move by line
-- nnoremap j gj
-- nnoremap k gk

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Theme
    {
      -- 'morhetz/gruvbox',
      'nanotech/jellybeans.vim',
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
	-- load the colorscheme here
	vim.cmd([[colorscheme jellybeans]])
      end,
    },

    -- LSP Support
    'nvim-treesitter/nvim-treesitter',
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    { 'hrsh7th/nvim-cmp'},
    { 'hrsh7th/cmp-nvim-lsp'},
    { 'L3MON4D3/LuaSnip'},

    -- Helpful ones
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "tpope/vim-sleuth",
    'junegunn/fzf',
    'junegunn/fzf.vim',

    -- Do we need these?
    { "folke/which-key.nvim", lazy = true },
    'nvim-lualine/lualine.nvim',
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "jellybeans" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- LSP mason integration (do this before setting up any other LS servers)
require('mason').setup()
require('mason-lspconfig').setup()

require('lualine').setup {
  options = {
    theme = 'jellybeans'
  }
}

require('which-key').setup {}

-- Configure nvim-cmp
local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})

-- Configure nvim-lspconfig
local lsp_zero = require("lsp-zero")
local lsp_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  lsp_zero.default_keymaps({buffer = bufnr})
end
lsp_zero.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = lsp_attach,
  float_border = 'rounded',
  sign_text = true,
})
