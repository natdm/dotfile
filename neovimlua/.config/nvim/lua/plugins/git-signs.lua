return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  event = "BufReadPre", -- won't load on startup without this
  keys = {
    {
      "<leader>hd",
      "<cmd>lua require('gitsigns').diffthis(nil, { vertical = true, ignore_blank_lines = true })<CR>",
      desc = "Diff",
    },
    {
      "<leader>hs",
      "<cmd>lua require('gitsigns').stage_hunk()<CR>",
      desc = "Stage hunk",
    },
    {
      "<leader>hu",
      "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>",
      desc = "Undo stage hunk",
    },
    {
      "<leader>hr",
      "<cmd>lua require('gitsigns').reset_hunk()<CR>",
      desc = "Reset hunk",
    },
    {
      "<leader>gR",
      "<cmd>lua require('gitsigns').reset_buffer()<CR>",
      desc = "Reset buffer",
    },
    {
      "<leader>hp",
      "<cmd>lua require('gitsigns').preview_hunk()<CR>",
      desc = "Preview hunk",
    },
    {
      "<leader>hb",
      "<cmd>lua require('gitsigns').blame_line()<CR>",
      desc = "Blame line",
    },
    {
      "<leader>hh",
      "<cmd>lua require('gitsigns').next_hunk()<CR>",
      desc = "Next hunk",
    },
    {
      "<leader>hH",
      "<cmd>lua require('gitsigns').prev_hunk()<CR>",
      desc = "Prev hunk",
    }
  },
  config = function()
    local updatetime = vim.api.nvim_get_option_value("updatetime", { scope = "global" })
    require("gitsigns").setup({
      signs = { add = { text = "│" }, change = { text = "│" } },
      auto_attach = true,
      current_line_blame = true,
      current_line_blame_opts = { 
        delay = updatetime,
      },
      sign_priority = 1,
      update_debounce = updatetime,
      preview_config = { border = "rounded", row = 1, col = 0 },
    })
  end
}
