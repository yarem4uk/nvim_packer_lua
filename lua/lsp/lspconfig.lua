-- local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
-- if not status_ok then
--   return
-- end

-- local protocol = require('vim.lsp.protocol')

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {'sumneko_lua'}
})

-- local sumneko_opts = require('lsp.settings.sumneko_lua')
-- opts = vim.tbl_deep_extand('force', sumneko_opts, opts)


require('lspconfig').sumneko_lua.setup{
}
