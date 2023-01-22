local color = 'gruvbox-material'

local status_ok, _ = pcall(vim.cmd, 'colo ' .. color)
if not status_ok then
  vim.notify('colorsheme ' .. color .. ' not found!')
  return
end
