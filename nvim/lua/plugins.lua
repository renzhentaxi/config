local function treeSitterConfig()
	require 'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			use_languagetree = true
		}
	}
end




local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

