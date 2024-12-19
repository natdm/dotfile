return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  -- init = function()
  --   require("nvim-treesitter.configs").setup({
  --     -- Automatically install missing parsers when entering buffer
  --     -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  --     auto_install = true,
  --   })
  -- end,
}
