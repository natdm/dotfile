local fn = vim.fn

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
	use("bennypowers/template-literal-comments.nvim")
	use("github/copilot.vim")
	use({
		"bennypowers/template-literal-comments.nvim",
		config = require("template-literal-comments").setup(),
		opt = true,
		ft = {
			"javascript",
			"typescript",
		},
	})
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("wbthomason/packer.nvim")
	-- colorscheme
	use("sainnhe/everforest")

	-- searching
	-- NOTE: There's a telescope-fzf plugin that might be better suited for all this
	use("junegunn/fzf")
	use({
		"junegunn/fzf.vim",
		config = require("plugins.configs.fzf"),
		run = function()
			fn["fzf#install()"](0)
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
	use("artempyanykh/marksman") -- markdown lsp
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = require("trouble").setup({}),
	})
	use({
		"scalameta/nvim-metals",
		requires = { "nvim-lua/plenary.nvim" },
	})
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
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	})

	use({
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = require("fidget").setup({}),
	})

	-- languages
	use("python/black")
	-- use("arp242/gopher.vim") - this is a pita, I'd rather the old go plugin
	use({
		"fatih/vim-go",
		config = require("plugins.configs.vim-go"),
	})
	use("pangloss/vim-javascript")
	use("leafgarland/typescript-vim")
	use({
		"mattn/emmet-vim",
		config = require("plugins.configs.emmet"),
	})
	use("chrisbra/csv.vim")
	use({
		"ellisonleao/glow.nvim",
		config = require("plugins.configs.glow"),
	})
	-- Disabling prettier for now since it uses nullls and I'm trying
	-- to consolidate language server functionality. I'm using
	-- numtostr prettierls which has more basic functionality.
	--
	use({
		"MunifTanjim/prettier.nvim",
		config = require("plugins.configs.prettier"),
	})
	-- use("numToStr/prettierrc.nvim")

	-- specifically lua nvim development plugin
	use("folke/neodev.nvim")
	use({ "mhartington/formatter.nvim", config = require("plugins.configs.formatter") })

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
	-- use({ "rcarriga/nvim-notify" })
	-- debugging
	use("leoluz/nvim-dap-go")
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

	-- swagger
	use({
		"vinnymeller/swagger-preview.nvim",
		run = "npm install -g swagger-ui-watcher",
		config = require("plugins.configs.swagger"),
	})
end)
