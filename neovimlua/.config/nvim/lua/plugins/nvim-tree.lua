vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too
return {
  "nvim-tree/nvim-tree.lua",
  name = "nvimtree",
  keys = { { "t", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" } },
  opts = {
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    --  trying https://github.com/MarioCarrion/videos/blob/269956e913b76e6bb4ed790e4b5d25255cb1db4f/2023/01/nvim/lua/plugins/nvim-tree.lua
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
      relativenumber = true,
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2)
              - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },
    -- end trying


    -- disable_netrw = false,
    -- view = { adaptive_size = true },
    -- renderer = {
    --   highlight_opened_files = "name",
    --   icons = {
    --     glyphs = {
    --       default = "",
    --       symlink = "",
    --       git = {
    --         unstaged = "✗",
    --         staged = "✓",
    --         unmerged = "",
    --         renamed = "➜",
    --         untracked = "★",
    --         deleted = "",
    --         ignored = "◌",
    --       },
    --       folder = {
    --         arrow_open = "",
    --         arrow_closed = "",
    --         default = "",
    --         open = "",
    --         empty = "",
    --         empty_open = "",
    --         symlink = "",
    --         symlink_open = "",
    --       },
    --     },
    --   },
    -- },
    -- actions = { open_file = { quit_on_open = true } },
    -- diagnostics = { enable = true },
    -- update_focused_file = {
    --   enable = true,
    --   -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    --   -- only relevant when `update_focused_file.enable` is true
    --   -- update_cwd = true,
    --   -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    --   -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    --   ignore_list = {},
    -- },
  },
}
