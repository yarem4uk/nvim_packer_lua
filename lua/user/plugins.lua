local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('packer')
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
end

-- Automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  print('packer is not installed')
	return
end


return packer.startup(function(use)
	-- My plugins here
	use('wbthomason/packer.nvim')
	use('nvim-lua/popup.nvim')
	use('nvim-lua/plenary.nvim')

	use('tpope/vim-sensible')
	use('tpope/vim-surround')
	use('tpope/vim-repeat')
	use('tpope/vim-commentary')

        --use('lifepillar/vim-gruvbox8')
	use('sainnhe/gruvbox-material')


	use({
		'nvim-lualine/lualine.nvim',
		-- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	})

	use('kyazdani42/nvim-tree.lua')

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		packer.sync()
	end
end)
