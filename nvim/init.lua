-- copy/paste setup from lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- set mapleader before lazy
vim.g.mapleader = ' ' -- <space> as leader

require("lazy").setup({
	{
		'nanotech/jellybeans.vim',
		lazy = false,
		config = function()
			vim.cmd([[colorscheme jellybeans]])
		end
	},
	--'morhetz/gruvbox',

	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },

	-- LSP Support
	{ 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
	{ 'neovim/nvim-lspconfig' },
	-- autocompletion?! why is not built-in....
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
		end,
	},
	{ "L3MON4D3/LuaSnip", version = "v2.*" },

	'rafamadriz/friendly-snippets', -- community snippets for all the languages

	-- -- Helpful ones
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"tpope/vim-sleuth",
	'junegunn/fzf',
	'junegunn/fzf.vim',

	-- -- Do we need these?
	--'sheerun/vim-polyglot',
	'folke/which-key.nvim',
	-- 'github/copilot.vim',
	--'sgur/vim-editorconfig', -- dont think this is needed anylonger, default is nvim
	{
		'nvim-lualine/lualine.nvim',
		--dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	-- 'prettier/vim-prettier',
	--  'evanleck/vim-svelte';
	-- 'tpope/vim-fugitive' " git stuff
	-- 'suy/vim-context-commentstring' " proper comments for <script> tags etc.
	-- 'projekt0n/github-nvim-theme';
	-- 'wuelnerdotexe/vim-astro';
	-- 'w0rp/ale' " linter
	-- 'brooth/far.vim' " search/replace
	-- 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	-- 'neoclide/coc.vim';
})

require('lualine').setup {
	options = {
		theme = 'jellybeans'
	}
}
require('which-key').setup {}

-- LSP setup
local lsp_zero = require("lsp-zero")
lsp_zero.preset("recommended")

-- LSP mason integration
require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here with the ones you want to install
	-- ensure_installed = {'tsserver', 'rust_analyzer'},
	handlers = {
		lsp_zero.default_setup,
	},
})
require('mason-lspconfig').setup({})

-- LSP lua setup (just for this config, really)
local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	lsp_zero.default_keymaps({ buffer = bufnr })
	-- local opts = {buffer = bufnr, remap = false}
	-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
local luasnip = require("luasnip")
local cmp = require("cmp")

-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp_zero.defaults.cmp_mappings({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })
--

-- testing this out, not sure
cmp.setup({
  -- ... Your other configuration ...

  mapping = {
    -- ... Your other mappings ...
   ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- ... Your other mappings ...
  },

  -- ... Your other configuration ...
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- lsp_zero.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })

-- lsp_zero.set_preferences({
--   sign_icons = {
--     error = 'E',
--     warn = 'W',
--     hint = 'H',
--     info = 'I'
--   }
-- })
lsp_zero.setup()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- Indention
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Make new splits open towards right and bottom (by default it is the opposite)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- case-insensitive searching
vim.opt.smartcase = true  -- but become case-sensitive if you type uppercase

-- vim.api.nvim_create_autocmd('TextYankPost', {
-- })

-- To be documented
vim.opt.updatetime = 250 -- cool people do it
vim.opt.timeoutlen = 500
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'yes'
-- set hidden " Allow buffer switching even if unsaved
vim.opt.scrolloff = 2 -- Start scrolling X lines before top/end

-- Colors
vim.opt.termguicolors = true

-- Navigation
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
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

-- Use semi-colon to enter command mode because it's one less key
-- nmap ; :

-- Instead of ctrl-w then j, it’s just ctrl-j:
-- noremap <C-J> <C-W><C-J>
-- nnoremap <C-K> <C-W><C-K>
-- nnoremap <C-L> <C-W><C-L>
-- nnoremap <C-H> <C-W><C-H>

-- Move by line
-- nnoremap j gj
-- nnoremap k gk

-- Setup svelte
vim.cmd [[
let g:svelte_preprocessor_tags = [
\ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
\ ]
let g:svelte_preprocessors = ['ts']
]]



