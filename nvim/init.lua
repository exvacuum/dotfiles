-- Plugins
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local has_local_setup, local_setup = pcall(require, "local/init")

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'goolord/alpha-nvim',
		config = function() require('alpha').setup(require('plugin/alpha-theme').config) end
	}

	use {
		'xiyaowong/transparent.nvim',
		config = function() require('transparent').setup() end
	}

	use {
		"nvim-telescope/telescope.nvim",
		config = function() require('plugin/telescope') end
	}

	use {
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" }
	}
	use {
		'neovim/nvim-lspconfig',
		config = function() require('plugin/nvim-lspconfig') end
	}

	use {
		'L3MON4D3/LuaSnip',
		config = function () require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"}) end
	}

	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
  			'micangl/cmp-vimtex',
			'hrsh7th/cmp-cmdline',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function() require('plugin/nvim-cmp') end
	}


	use {
		"nvim-treesitter/nvim-treesitter",
		config = function() require('plugin/treesitter') end
	}

	use {
		"nvim-lualine/lualine.nvim",
		config = function() require('plugin/lualine') end
	}

	use {
	 	'akinsho/toggleterm.nvim',
		config = function() require('plugin/toggleterm') end
	}

	use {
		'natecraddock/workspaces.nvim',
		config = function() require('workspaces').setup() end
	}

	use {
		'barrett-ruth/live-server.nvim',
		config = function() require('live-server').setup() end
	}

	use {
		'ray-x/lsp_signature.nvim',
		config = function ()
			require('lsp_signature').setup();
		end
	}

	use {
		'lervag/vimtex',
		config = function () require('plugin/vimtex') end
	}

	if has_local_setup then local_setup.packer(use) end
	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- Options
vim.o.number = 1
vim.o.relativenumber = 1
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax enable')

-- Keybinds
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope file_browser path=%:p:h<CR>', opts)
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
vim.keymap.set('n', '<leader>vs', '<cmd>vs Telescope file_browser path=%:p:h<CR>', opts)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local keybind_opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, keybind_opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keybind_opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, keybind_opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, keybind_opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, keybind_opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, keybind_opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, keybind_opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, keybind_opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, keybind_opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, keybind_opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, keybind_opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, keybind_opts)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, keybind_opts)
	end,
})

if has_local_setup then local_setup.setup() end
