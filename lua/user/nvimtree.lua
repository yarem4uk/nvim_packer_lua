vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
    ignored = '',
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
}

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

local status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  -- quit_on_open = 1,
  -- update_to_buf_dir = {
  --   enable = true,
  --   auto_open = true,
  -- },
  diagnostics = {
    enable = false,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  update_focused_file = {
    enable = false,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = true,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 25,
    -- height = 30,
    hide_root_folder = false,
    side = 'left',
    -- auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = 'h', cb = tree_cb('close_node') },
      },
    },
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
  -- show_icons = {
  --   git = '',
  --   folders = '',
  --   files = '',
  --   folder_arrows = '',
  -- },
})
