return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  config = true,
}
