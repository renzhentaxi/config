
-- bootstrap
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local nulllsConfig = function()
	require("null-ls").config({
		sources = {
			require("null-ls").builtins.formatting.prettierd,
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.shfmt.with({
				filetypes = { "sh", "bash" },
			}),
		},
	})

	require("lspconfig")["null-ls"].setup({
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("neovim/nvim-lspconfig")
	use("ggandor/lightspeed.nvim")
	use("folke/tokyonight.nvim")
	use("L3MON4D3/LuaSnip")

	use({
		"hrsh7th/nvim-cmp",
		config = require("plugin_configs.nvim_cmp").setup,
		requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require("plugin_configs.treesitter").setup,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = nulllsConfig,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})

	use("tpope/vim-fugitive")
end)
