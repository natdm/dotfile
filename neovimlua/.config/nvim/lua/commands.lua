-- Toggle the split size between full and original size
local split_original_size = nil

vim.api.nvim_create_user_command('ToggleSplitSize', function()
    local current_win = vim.api.nvim_get_current_win()
    local current_size = vim.api.nvim_win_get_height(current_win)
    local total_size = vim.o.lines - 2  -- -2 for the command line and status line

    if not split_original_size then
        -- Save the original size and expand
        split_original_size = current_size
        vim.api.nvim_win_set_height(current_win, total_size)
    else
        -- Restore the original size
        vim.api.nvim_win_set_height(current_win, split_original_size)
        split_original_size = nil
    end
end, {})

-- this is like res (resize) horizontally but for vertically
vim.api.nvim_create_user_command(
  'Vres',
  function(opts)
    vim.cmd('vertical resize ' .. opts.args)
  end,
  { nargs = 1 }
)
