local map = vim.api.nvim_set_keymap

local M = {}

function M.nmap(pattern, action)
  local options = {}
  map("n", pattern, action, options)
end

function M.nmapsl(pattern, action)
  local options = { noremap = true, silent = true }
  map("n", "<leader>" .. pattern, action, options)
end

function M.nmaps(pattern, action)
  local options = { noremap = true, silent = true }
  map("n", pattern, action, options)
end

function M.nmapl(pattern, action)
  local options = { noremap = true }
  map("n", "<leader>" .. pattern, action, options)
end

function M.imap(pattern, action)
  local options = { noremap = true }
  map("i", pattern, action, options)
end

function M.vmap(pattern, action)
  local options = { noremap = true }
  map("v", pattern, action, options)
end

function M.vmapsl(pattern, action)
  local options = { noremap = true, silent = true }
  map("v", "<leader>" .. pattern, action, options)
end

function M.vmapl(pattern, action)
  local options = { noremap = true }
  map("v", "<leader>" .. pattern, action, options)
end

return M
