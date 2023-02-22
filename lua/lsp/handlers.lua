local M = {}

M.keymap = function(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', '')
  nmap('gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', '')

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
  -- if client.name == 'tsserver' then
  --   client.server_capabilities.document_formatting = false
  --   client.server_capabilities.document_range_formatting = false
  -- end

  M.keymap(bufnr)
end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
