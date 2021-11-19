local function treeSitterConfig()
	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			use_languagetree = true,
		},
	})
end

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
	use("hrsh7th/nvim-compe")
	use("neoclide/vim-jsx-improve")
	use("ggandor/lightspeed.nvim")
	use("folke/tokyonight.nvim")
	use("folke/which-key.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = treeSitterConfig,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = nulllsConfig,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})

	use("tpope/vim-fugitive")
end)
