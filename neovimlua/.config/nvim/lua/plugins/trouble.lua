return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>gr",
      "<cmd>Trouble lsp_references toggle<cr>",
      desc = "Goto References (Trouble)",
    },
    {
      "<leader>D",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>d",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>i",
      "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
      desc = "LSP Info / Definitions / References /... (Trouble)",
    },
    {
      "<leader>l",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>q",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
