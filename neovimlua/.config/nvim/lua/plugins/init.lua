local cmd = vim.cmd
local fn = vim.fn

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Auto compile when there are changes in plugins.lua
cmd("autocmd BufWritePost plugins.lua PackerCompile")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- colorscheme
	use("tjdevries/colorbuddy.vim") -- colorscheme creator, needed for a few of these
	use("rakr/vim-one")
	use("rebelot/kanagawa.nvim")
	use("sainnhe/everforest")
	use("sainnhe/edge")
	use("sainnhe/sonokai")
	use("bluz71/vim-nightfly-guicolors")
	use("glepnir/zephyr-nvim")
	use("Th3Whit3Wolf/onebuddy")
	use("EdenEast/nightfox.nvim")
	use("Th3Whit3Wolf/space-nvim")
	use("navarasu/onedark.nvim")
	use("sam4llis/nvim-tundra")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- colorscheme switching
	use("xolox/vim-colorscheme-switcher")
	use("xolox/vim-misc")
	-- searching
	-- NOTE: There's a telescope-fzf plugin that might be better suited for all this
	use("junegunn/fzf")
	use({
		"junegunn/fzf.vim",
		config = require("plugins.configs.fzf"),
		run = function()
			vim.fn["fzf#install()"](0)
		end,
	})
	-- explorer
	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		config = require("plugins.configs.nvimtree"),
		requires = "kyazdani42/nvim-web-devicons",
	})
	-- git/github
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = require("plugins.configs.gitsigns"),
	})
	use({
		"ldelossa/gh.nvim",
		requires = { "ldelossa/litee.nvim" },
		config = require("plugins.configs.gh"),
	})
	-- git conflicts
	use({
		"akinsho/git-conflict.nvim",
		config = require("plugins.configs.gitconflict"),
	})

	-- fugitive is a git plugin. rhubarb is required
	-- to be able to open a file in browser (:GBrowse)
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("artempyanykh/marksman") -- markdown lsp
	use({
		"ray-x/lsp_signature.nvim",
		config = require("plugins.configs.lspsignature"),
	})
	use({
		-- prettier diagnostics, I don't use it a lot but
		-- but maybe I should. No keybindings, just
		-- :Trouble<cmd>
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = require("trouble").setup({}),
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = require("plugins.configs.null-ls"),
	})
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		config = require("plugins.configs.cmp"),
		requires = {
			"hrsh7th/cmp-buffer", --
			"ray-x/cmp-treesitter", --
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind-nvim",
		},
	})

	use({
		"j-hui/fidget.nvim",
		config = require("fidget").setup({}),
	})

	-- languages
	use("fatih/vim-go")
	use("pangloss/vim-javascript")
	use("leafgarland/typescript-vim")
	use("peitalin/vim-jsx-typescript")
	use("styled-components/vim-styled-components")
	use("mattn/emmet-vim")
	use("elixir-editors/vim-elixir")
	use("chrisbra/csv.vim")
	use("ellisonleao/glow.nvim")
	use({
		"MunifTanjim/prettier.nvim",
		config = require("plugins.configs.prettier"),
	})
	-- specifically lua nvim development plugin
	use({
		"folke/neodev.nvim",
		config = require("plugins.configs.luadev"),
	})

	-- tests
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		},
		config = require("plugins.configs.nvimtest"),
	})
	-- snippets
	use("L3MON4D3/LuaSnip")
	use({
		"saadparwaiz1/cmp_luasnip",
		config = require("plugins.configs.snippets"),
	})

	-- app integrations
	use("robbyrussell/oh-my-zsh")
	use("christoomey/vim-tmux-navigator")

	-- motions
	use("wellle/targets.vim")
	use({
		"numToStr/Comment.nvim",
		config = require("Comment").setup(),
	})
	use("tpope/vim-surround")
	use("jiangmiao/auto-pairs")

	-- patches
	-- cursorhold: https://github.com/neovim/neovim/issues/12587
	use("antoinemadec/FixCursorHold.nvim")

	-- other
	-- use({
	-- 	"folke/todo-comments.nvim",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- 	config = require("todo-comments").setup({}),
	-- })
	use("editorconfig/editorconfig-vim")
	use("AndrewRadev/switch.vim") -- flipping values like booleans, <l>ss
	use("yuttie/comfortable-motion.vim")
	use("easymotion/vim-easymotion")
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = require("plugins.configs.lualine"),
	})
	use("rhysd/committia.vim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require("plugins.configs.treesitter"),
	})
	use("nvim-treesitter/playground")
	-- use("sunjon/shade.nvim") -- this is busted, breaking gh
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "rcarriga/nvim-notify" })
	-- debugging
	use({
		"mfussenegger/nvim-dap",
		requires = {
			{ "leoluz/nvim-dap-go" },
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "nvim-telescope/telescope-dap.nvim" },
		},
		config = require("plugins.configs.nvim-dap"),
	})
end)
