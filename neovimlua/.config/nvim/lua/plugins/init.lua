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
	-- require("plugins.gh"), -- disabling for now in favor of neogit and octo
	-- require("plugins.temporal"),
	require("plugins.cmp"),
	-- require("plugins.blink"), -- this was not great, maybe needs more configuration.
	require("plugins.codecompanion"),
	require("plugins.colortheme"),
	require("plugins.comfortable-motion"),
	require("plugins.comment"),
	require("plugins.copilot"),
	require("plugins.dadbod"),
	-- require("plugins.flash"),
	require("plugins.fzf"),
	require("plugins.fzf-lua"),
	require("plugins.git-signs"), -- I had hoped this wouldn't be needed with neogit but I can't get neogit to show hunks
	-- require("plugins.lualine"),
  require('plugins.lazydev'),
	require("plugins.lualine-simple"),
	require("plugins.neo-tree"),
	require("plugins.neogit"),
	require("plugins.neotest"),
	require("plugins.octo"),
	require("plugins.overseer"),
	require("plugins.pr"),
	require("plugins.rhubarb"),
  -- https://www.youtube.com/watch?v=NJDu_53T_4M
	require("plugins.surround"),
	require("plugins.tmux-navigator"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
  require("plugins.lsp"),
  require("plugins.lsp_diagnostic_manipulation"),
  require("plugins.markdown"),
  require("plugins.snake"),
  require("plugins.spectre"),
  require("plugins.transparent"),
  require("plugins.which-key"),
	require("plugins.easymotion"),
}
local opts = {}

require("lazy").setup(plugins, opts)

