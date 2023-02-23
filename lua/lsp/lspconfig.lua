local mason_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_ok then
  return
end

local servers = {
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  jsonls = {},
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
    },
  },
}

require('mason').setup()

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({

      capabilities = require('lsp.handlers').capabilities,
      on_attach = require('lsp.handlers').on_attach,
      settings = servers[server_name],
    })
  end,
})
