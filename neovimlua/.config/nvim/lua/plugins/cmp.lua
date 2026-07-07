return {
  "hrsh7th/nvim-cmp",
  name = "cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      formatting = {},
      experimental = { ghost_text = true },
      mapping = {
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      },
      sources = {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lua" },
        { name = "buffer", keyword_length = 3, max_item_count = 10 },
        { name = "emoji" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
      },
    })
  end,
}
