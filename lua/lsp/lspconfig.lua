local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_ok then
  return
end

local servers = {
  html = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {
    -- compilerOptions = {
    --   checkJs = false,
    -- },
  },
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

require('lsp.handlers').setup()

mason.setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    -- if serner_name == 'tsserver' then
    -- init_options = {
    --     checkJs = true
    -- },
    -- end
    lspconfig[server_name].setup({
      capabilities = require('lsp.handlers').capabilities,
      on_attach = require('lsp.handlers').on_attach,
      settings = servers[server_name],
    })
  end,
})

mason_null_ls.setup({
  ensure_installed = {
    'prettier',
    'eslint_d',
    'stylelua',
    'flake8',
    'black',
  },
})
