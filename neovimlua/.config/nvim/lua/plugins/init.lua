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

	require("plugins.neo-tree"),
	require("plugins.colortheme"),
	require("plugins.comfortable-motion"),
	require("plugins.copilot"),
	require("plugins.easymotion"),
	require("plugins.fidget"),
	require("plugins.fzf"),
	require("plugins.fzf-vim"),
	require("plugins.git-signs"),
	require("plugins.lualine"),
	require("plugins.mason"),
	require("plugins.mason-lspconfig"),
	require("plugins.nvim-lspconfig"),
	require("plugins.tmux-navigator"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
}
local opts = {}

require("lazy").setup(plugins, opts)
