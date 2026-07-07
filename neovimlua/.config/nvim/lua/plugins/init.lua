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
  require("plugins.codecompanion"),
  require("plugins.colortheme"),
  require("plugins.comfortable-motion"),
  require("plugins.comment"),
  require("plugins.copilot"),
  require("plugins.dadbod"),
  require("plugins.easymotion"),
  require("plugins.fzf"),
  require("plugins.fzf-lua"),
  require("plugins.git-signs"),
  require("plugins.lazydev"),
  require("plugins.lsp"),
  require("plugins.lsp_diagnostic_manipulation"),
  require("plugins.lualine-simple"),
  require("plugins.markdown"),
  require("plugins.neo-tree"),
  require("plugins.neogit"),
  require("plugins.neotest"),
  require("plugins.octo"),
  require("plugins.overseer"),
  require("plugins.pr"),
  require("plugins.rhubarb"),
  require("plugins.snake"),
  require("plugins.spectre"),
  require("plugins.surround"),
  require("plugins.tmux-navigator"),
  require("plugins.transparent"),
  require("plugins.treesitter"),
  require("plugins.trouble"),
  require("plugins.which-key"),
}
local opts = {}

require("lazy").setup(plugins, opts)

