local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'folke/tokyonight.nvim'
	use 'neoclide/vim-jsx-improve'
	use 'ggandor/lightspeed.nvim'
	use 'folke/which-key.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
end)
