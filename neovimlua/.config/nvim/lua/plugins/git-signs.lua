return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  keys = {
    {
      "<leader>hs",
      "<cmd>lua require('gitsigns').stage_hunk()<CR>",
    },
    {
      "<leader>hu",
      "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>",
    },
    {
      "<leader>hr",
      "<cmd>lua require('gitsigns').reset_hunk()<CR>",
    },
    {
      "<leader>gR",
      "<cmd>lua require('gitsigns').reset_buffer()<CR>",
    },
    {
      "<leader>hp",
      "<cmd>lua require('gitsigns').preview_hunk()<CR>",
    },
    {
      "<leader>hb",
      "<cmd>lua require('gitsigns').blame_line()<CR>",
    },
    {
      "<leader>hh",
      "<cmd>lua require('gitsigns').next_hunk()<CR>",
    },
    {
      "<leader>hH",
      "<cmd>lua require('gitsigns').prev_hunk()<CR>",
    }
  },
  config = function()
    require("gitsigns").setup()
  end
}
