return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  config = true,
  keys = {
    {
      "<leader>ccc",
      "<cmd>CodeCompanionChat<CR>",
      mode = "n",
      desc = "CodeCompanionChat",
    },
    {
      "<leader>cct",
      "<cmd>CodeCompanionChat toggle<CR>",
      mode = "n",
      desc = "CodeCompanionChat toggle",
    },
    {
      "<leader>cac",
      "<cmd>CodeCompanion /commit<CR>",
      mode = "n",
      desc = "CodeCompanion Action Commit Msg",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
