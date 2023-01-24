local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  print('no')
  return
end

-- local status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
-- if not status_ok then
--   return
-- end

nvim_tree.setup()
