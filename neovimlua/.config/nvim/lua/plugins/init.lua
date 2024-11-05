local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- these seem to slow down nvim
	-- require("plugins.nvim-tree"),
	-- require("plugins.nvim-web-devicons"),

	require("plugins.cmp"),
	require("plugins.colortheme"),
	require("plugins.comfortable-motion"),
	require("plugins.comment"),
	require("plugins.copilot"),
	require("plugins.copilot-chat"),
	require("plugins.easymotion"),
	require("plugins.fugitive"),
	require("plugins.fzf"),
	require("plugins.fzf-vim"),
	require("plugins.gh"),
	require("plugins.git-signs"),
	require("plugins.lualine"),
	require("plugins.neo-tree"),
	require("plugins.neotest"),
	require("plugins.rhubarb"),
	require("plugins.tmux-navigator"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
  require("plugins.lsp_diagnostic_manipulation"),
  require("plugins.markdown"),
  require("plugins.spectre"),
  require("plugins.which-key"),
--	require("plugins.conform"),
--	require("plugins.lsp"),
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("lazy-config.null-ls")  -- Separate file for the configuration
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",  -- Lazy load on buffer read
    config = function()
      require("lazy-config.lsp")  -- Separate file for LSP configuration
    end,
  },
}
local opts = {}

require("lazy").setup(plugins, opts)
