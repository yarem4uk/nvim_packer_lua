local M = {}

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '✗' },
    { name = 'DiagnosticSignWarn',  text = 'ί' },
    { name = 'DiagnosticSignHint',  text = 'h' },
    { name = 'DiagnosticSignInfo',  text = '?' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- virtual_lines = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    -- float = {
    --   focusable = true,
    --   style = 'minimal',
    --   border = 'rounded',
    --   source = 'always',
    --   header = '',
    --   prefix = '',
    -- },
  }

  vim.diagnostic.config(config)
end

M.keymap = function(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', '<cmd>Telescope lsp_definitions<cr>', '[G]oto [D]efinition')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', '')
  nmap('gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', '')
  nmap('<leader>dl', '<cmd>Telescope diagnostics<cr>', '')

  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
    -- buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

M.on_attach = function(_, bufnr)
  M.keymap(bufnr)
end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
  return
end

M.capabilities = function(name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if name == 'tsserver' then
    capabilities.textDocument = capabilities.textDocument or {}
    capabilities.textDocument.diagnostic = capabilities.textDocument.diagnostic or {}
    capabilities.textDocument.diagnostic.disable = true
  end
  return cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
