-- mapleader 
vim.g.mapleader = ' ' -- <space> as leader
vim.g.maplocalleader = '  '

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = false -- hide because our statusline does it

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.o.swapfile = false
vim.o.cursorline = true
vim.o.signcolumn = 'yes'

-- Indention
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 0 -- falls back to tabstop?
-- vim.o.expandtab = true

-- Set highlight on search, but clear on ESC
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.o.ignorecase = true -- case-insensitive searching
vim.o.smartcase = true  -- but case-sensitive when you type uppercase
vim.o.incsearch = true
vim.o.inccommand = 'split' -- preview substitions live

-- To be documented
vim.o.updatetime = 250 -- cool people do it
vim.o.timeoutlen = 300

-- Make new splits open towards right and bottom (by default it is the opposite)
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.confirm = true -- not sure, testing it

-- set hidden " Allow buffer switching even if unsaved
vim.o.scrolloff = 6 -- Start scrolling X lines before top/end

-- Colors
vim.o.termguicolors = true
vim.o.winborder = 'rounded' -- default border for floating windows


-- vim.keymap.set('n', '<space>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>')

vim.keymap.set('n', '<leader>f', function()
	vim.lsp.buf.format()
end)

-- Navigation with fzf
vim.api.nvim_set_keymap("n", "<C-\\>", [[<Cmd>lua require"fzf-lua".buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>b", [[<Cmd>lua require"fzf-lua".buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-k>", [[<Cmd>lua require"fzf-lua".builtin()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require"fzf-lua".files()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-l>", [[<Cmd>lua require"fzf-lua".live_grep()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-g>", [[<Cmd>lua require"fzf-lua".grep_project()<CR>]], {})
vim.api.nvim_set_keymap("n", "<F1>", [[<Cmd>lua require"fzf-lua".help_tags()<CR>]], {})
-- vim.keymap.set('n', '<leader>p', '<cmd>Files<cr>') -- or GitFiles
-- vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>')
-- vim.keymap.set('n', '<leader>a', '<cmd>Rg<cr>') -- Can try both Ag or Rg. from fzf.vim
-- vim.keymap.set('i', '<c-x><c-l>', '<plug>(fzf-complete-line)')


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

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup('oskar-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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
		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
		},

		{
			'saghen/blink.cmp',
			version = '1.*', -- necessary to install pre-built fuzzy binaries
		},

		-- GUI for installing language servers
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"mason-org/mason.nvim",
					opts = {}
				},
				'saghen/blink.cmp'
			},
			config = function()

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('oskar-lsp', { clear = true }),
    callback = function(e)
        local opts = { buffer = e.buf }

	-- from neovim lsp defaults
	-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
	-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
	-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
	-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
	-- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
	-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
	-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
	-- "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()
	--
	-- from kickstart.nvim
	-- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          -- local map = function(keys, func, desc, mode)
          --   mode = mode or 'n'
          --   vim.keymap.set(mode, keys, func, { buffer = e.buf, desc = 'LSP: ' .. desc })
          -- end

          -- Rename the variable under your cursor.
          -- map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          -- map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	  --
          -- map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
	  --
		-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
		-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
		-- "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

	-- from primeagen
        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

			end
		},


		-- Helpful ones
		"tpope/vim-surround",
		"tpope/vim-commentary",
		"tpope/vim-sleuth",
		"tpope/vim-fugitive",

		-- 'junegunn/fzf',
		-- 'junegunn/fzf.vim',
		{
		  "ibhagwan/fzf-lua",
		  -- optional for icon support
		  dependencies = { "nvim-tree/nvim-web-devicons" },
		  -- or if using mini.icons/mini.nvim
		  -- dependencies = { "nvim-mini/mini.icons" },
		  opts = {}
		},

		'leafOfTree/vim-svelte-plugin',

		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- delay = 0
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({global = false})
					end,
					desc = "Buffer local keymaps (which-key)"
				}
			}
		},

		'nvim-lualine/lualine.nvim',

		{
			'saghen/blink.cmp',

			-- optional: provides snippets for the snippet source
			dependencies = { 'rafamadriz/friendly-snippets' },

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = 'super-tab' },

				completion = {
					documentation = { auto_show = false, auto_show_delay_ms = 500 },
					-- ghost_text = { enabled = false }, -- default = false
				},

				signature = {
					enabled = true -- show help while you type function args
				},

				-- Default list of enabled providers defined so that you can extend it
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

				fuzzy = { implementation = "prefer_rust" }
			},
			opts_extend = { "sources.default" }
		},
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = {colorscheme = {"jellybeans" }},
	-- automatically check for plugin updates
	checker = {enabled = false},
	change_detection = {enabled = false},
})

require('lualine').setup {
	options = {
		theme = 'jellybeans'
	},
	sections = {
		lualine_c = {
			{
				'filename',
				path = 1
					-- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory
			}
		}
	}
}

-- LSP
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc=  'Open diagnostics' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc= 'Open float diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- extend lua lsp settings to silence the global `vim` warning
vim.lsp.config('lua_ls', {
	settings = {
		Lua = { diagnostics = { globals = { "vim" } } }
	}
})

-- configs are from nvim-lspconfig
vim.lsp.enable('lua_ls')
vim.lsp.enable('html_lsp')
vim.lsp.enable('css_lsp')
vim.lsp.enable('ts_ls')
vim.lsp.enable('svelte')
vim.lsp.enable('biome')

require('which-key').setup {}
-- require('fzf-lua').setup({'fzf-native'})

