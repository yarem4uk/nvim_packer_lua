local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost user/plugins.lua source <afile> | PackerCompile
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

  -- themes
  --use('lifepillar/vim-gruvbox8')
  use('sainnhe/gruvbox-material')
  -- use('sainnhe/everforest')

  -- tree
  use({
    'nvim-tree/nvim-tree.lua',
    -- requires = {
    --   'nvim-tree/nvim-web-devicons', -- optional, for file icons
    -- },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  })

  -- lualine
  use({
    'nvim-lualine/lualine.nvim',
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- configuring lsp servers
  use({
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  })

  -- Autocompletion
  use({
    'hrsh7th/nvim-cmp',
    -- 'hrsh7th/cmp-nvim-lsp'
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    -- requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip' },
  })

  --formating & linting
  use('jose-elias-alvarez/null-ls.nvim')
  use('jay-babu/mason-null-ls.nvim')

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  })

  -- telescope
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  -- Fuzzy Finder for telescope
  -- use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable('make') == 1 })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  --
  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end)
