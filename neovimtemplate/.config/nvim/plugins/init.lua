local fn = vim.fn

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
	-- Plugin manager, to make sure you don't try to delete it.
	use("wbthomason/packer.nvim")

	-- Additional vim targets, for smoother text-object motions
	use("wellle/targets.vim")

	-- motions, press `s` then any character, then look where you want to go to hit THAT character.
	use("easymotion/vim-easymotion")

	-- Scrolling is less annoying with this, for people following your code
	use("yuttie/comfortable-motion.vim")

	-- a good git plugin.
	use("tpope/vim-fugitive")

	-- file explorer.
	use({
		"kyazdani42/nvim-tree.lua",
		config = require("plugins.configs.nvimtree"),
		requires = "kyazdani42/nvim-web-devicons",
	})
end
