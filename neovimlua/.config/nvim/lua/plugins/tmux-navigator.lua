return {
	"alexghergh/nvim-tmux-navigation",
  keys = {
    {
      "<C-h>",
      "<cmd>NvimTmuxNavigateLeft<CR>",
      desc = "Navigate left",
    },
    {
      "<C-j>",
      "<cmd>NvimTmuxNavigateDown<CR>",
      desc = "Navigate down",
    },
    {
      "<C-k>",
      "<cmd>NvimTmuxNavigateUp<CR>",
      desc = "Navigate up",
    },
    {
      "<C-l>",
      "<cmd>NvimTmuxNavigateRight<CR>",
      desc = "Navigate right",
    },
    {
      "<C-\\>",
      "<cmd>NvimTmuxNavigateLastActive<CR>",
      desc = "Navigate last active",
    },
    {
      "<C-Space>",
      "<cmd>NvimTmuxNavigateNext<CR>",
      desc = "Navigate next",
    },
  },
	config = function()
		local nvim_tmux_nav = require("nvim-tmux-navigation")

		nvim_tmux_nav.setup({
			disable_when_zoomed = true, -- defaults to false
		})

--		vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
--		vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
--		vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
--		vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
--		vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
--		vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
	end,
}
