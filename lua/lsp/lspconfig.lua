local on_attach = function (_, bufnr)
  local nmap = function (keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', '')
  nmap('gj', '<cmd>lua vim.diagnostic.goto_next()<cr>',  '')
end

local servers = {
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = {'vim', 'use'}
      },
    },
  },
}

require('mason').setup()


local mason_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_ok then
  return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
  return
end

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers)
})


local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {

      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
