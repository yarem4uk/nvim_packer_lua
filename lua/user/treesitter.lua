local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = {'lua', 'python', 'typescript', 'javascript', 'help', 'rust', 'vim', 'regex', 'json'},

  highlight = { enable = true},
  indent = { enable = true},
  additional_vim_regex_highlighting = true,

  -- textobjects = {
  --     move = {
  --       enable = true,
  --       set_jumps = true,
  --       goto_next_start = {
  --         [']m'] = '@function.outer',
  --       },
  --     }
  -- }
})
