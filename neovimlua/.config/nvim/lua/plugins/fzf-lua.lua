return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {"<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>"},
    {"<leader>fg", "<cmd>lua require('fzf-lua').git_files()<CR>"},
    {"<leader>fG", "<cmd>lua require('fzf-lua').git_status()<CR>"},
    {"<leader>fl", "<cmd>lua require('fzf-lua').blines()<CR>"},
    {"<leader>ft", "<cmd>lua require('fzf-lua').treesitter()<CR>"},
    {"<leader>fs", "<cmd>lua require('fzf-lua').git_stash()<CR>"},
    {"<leader>fb", "<cmd>lua require('fzf-lua').git_blame()<CR>"},
    {"<leader>fr", "<cmd>lua require('fzf-lua').grep_project()<CR>"},
    {"<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<CR>"},
    {"s", "<cmd>lua require('fzf-lua').grep_visual()<CR>", mode = "v"},
    {"<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>"},
    {"<leader>fR", "<cmd>lua require('fzf-lua').resume()<CR>"},
  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end
}
