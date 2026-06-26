return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
		{
			"<leader>ff", 
			"<cmd>lua require('fzf-lua').files()<CR>",
      desc = "Find files"
		},
		{
			"<leader>fg", 
			"<cmd>lua require('fzf-lua').git_files()<CR>",
      desc = "Find git files"
		},
		{
			"<leader>fG", 
			"<cmd>lua require('fzf-lua').git_status()<CR>",
      desc = "Find modified git files"
		},
		{
			"<leader>fl", 
			"<cmd>lua require('fzf-lua').blines()<CR>",
      desc = "Find lines"
		},
		{
			"<leader>ft", 
			"<cmd>lua require('fzf-lua').treesitter()<CR>",
      desc = "Find treesitter nodes"
		},
    {
      "<leader>fM", 
      "<cmd>lua require('fzf-lua').grep({ search = '', cmd = 'git diff --name-only | xargs grep -n' })<CR>",
      desc = "Search in modified files"
    },
    {
      "<leader>fm",
      "<cmd>lua require('fzf-lua').marks()<CR>",
      desc = "Search in modified files"
    },
		{
			"<leader>fs", 
			"<cmd>lua require('fzf-lua').git_stash()<CR>",
      desc = "Find git stash"
		},
		{
			"<leader>fb", 
			"<cmd>lua require('fzf-lua').buffers()<CR>",
      desc = "Find buffers"
		},
		{
			"<leader>fB", 
			"<cmd>lua require('fzf-lua').git_blame()<CR>",
      desc = "Find git blame (file)"
		},
		{
			"<leader>fH", 
			"<cmd>lua require('fzf-lua').git_hunks({ diff_opts = '-w' })<CR>",
      desc = "Find git hunks (ignore whitespace)"
		},
		{
			"<leader>fp", 
			"<cmd>lua require('fzf-lua').grep_project()<CR>",
      desc = "Grep project lines"
		},
		{
			"<leader>fr", 
			"<cmd>lua require('fzf-lua').grep({ search = '' })<CR>",
      desc = "Grep project lines + names"
		},
		{
			"<leader>fw", 
			"<cmd>lua require('fzf-lua').grep_cword()<CR>",
      desc = "Grep word under cursor"
		},
		{
			"s", 
			"<cmd>lua require('fzf-lua').grep_visual()<CR>", 
			mode = "v"
		},
		{
			"<leader>fh", 
			"<cmd>lua require('fzf-lua').help_tags()<CR>",
      desc = "Find help tags"
		},
		{
			"<leader>fR", 
			"<cmd>lua require('fzf-lua').resume()<CR>",
      desc = "Resume last fzf command"
		},
  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      keymap = {
        builtin = {},
        fzf = {
          ["ctrl-a"] = "toggle-all",
          ["ctrl-d"] = "preview-page-down", -- no workie
          ["ctrl-u"] = "preview-page-up" -- no workie
        }
      },
      winopts = {
        fullscreen = true
      }
    })
  end
}
