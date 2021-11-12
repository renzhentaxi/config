local function treeSitterConfig()
	require 'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			use_languagetree = true
		}
	}
end




require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'neoclide/vim-jsx-improve'
	use 'ggandor/lightspeed.nvim'
	use 'folke/which-key.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}	
	
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = treeSitterConfig
	}


	use {
	    'kyazdani42/nvim-tree.lua',
	    requires = 'kyazdani42/nvim-web-devicons',
	    config = function() require'nvim-tree'.setup{} end
	}
	use 'folke/tokyonight.nvim'
end)

