return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  keys = {
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
    require("gitsigns").setup()
  end
}
