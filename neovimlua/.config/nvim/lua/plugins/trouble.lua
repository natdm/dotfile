return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>gr",
      "<cmd>Trouble lsp_references toggle<cr>",
      desc = "(Trouble) Goto References",
    },
    {
      "<leader>gD",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "(Trouble) Diagnostics",
    },
    {
      "<leader>gd",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "(Trouble) Buffer Diagnostics",
    },
    {
      "<leader>gi", -- NON-leader gi goes to the implementation, this shows info 
      "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
      desc = "(Trouble) LSP Info / Definitions / References /...",
    },
--     {
--       "<leader>l", --
--       "<cmd>Trouble loclist toggle<cr>",
--       desc = "(Trouble) Location List",
--     },
    {
      "<leader>q", -- shows the qf list but in trobule
      "<cmd>Trouble qflist toggle<cr>",
      desc = "(Trouble) Quickfix List",
    },
  },
}
