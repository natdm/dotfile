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
	require("plugins.cmp"),
	require("plugins.colortheme"),
	require("plugins.comfortable-motion"),
	require("plugins.comment"),
	require("plugins.copilot"),
	require("plugins.copilot-chat"),
	require("plugins.dadbod"),
	require("plugins.easymotion"),
	require("plugins.neogit"),
	require("plugins.fzf"),
	require("plugins.fzf-lua"),
	-- require("plugins.gh"), -- disabling for now in favor of neogit and octo
	require("plugins.git-signs"), -- I had hoped this wouldn't be needed with neogit but I can't get neogit to show hunks
	require("plugins.lualine"),
	require("plugins.neo-tree"),
	require("plugins.neotest"),
	require("plugins.octo"),
	require("plugins.overseer"),
	require("plugins.rhubarb"),
	require("plugins.temporal"),
	require("plugins.tmux-navigator"),
  require("plugins.transparent"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
  require("plugins.lsp_diagnostic_manipulation"),
  require("plugins.markdown"),
  require("plugins.snake"),
  require("plugins.spectre"),
  require("plugins.which-key"),
  require("plugins.lsp"),
}
local opts = {}

require("lazy").setup(plugins, opts)

