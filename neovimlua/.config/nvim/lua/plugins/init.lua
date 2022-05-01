local fn = vim.fn
local cmd = vim.cmd

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd "packadd packer.nvim"
end

cmd(
    [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)

-- Auto compile when there are changes in plugins.lua
cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require("packer").startup(
    function(use)
        -- colorscheme
        use "tjdevries/colorbuddy.vim" -- colorscheme creator, needed for a few of these
        use "rakr/vim-one"
        use "rebelot/kanagawa.nvim"
        use "sainnhe/everforest"
        use "sainnhe/edge"
        use "sainnhe/sonokai"
        use "bluz71/vim-nightfly-guicolors"
        use "glepnir/zephyr-nvim"
        use "Th3Whit3Wolf/onebuddy"
        use "EdenEast/nightfox.nvim"
        use "Th3Whit3Wolf/space-nvim"
        use "navarasu/onedark.nvim"

        -- colorscheme switching
        use "xolox/vim-colorscheme-switcher"
        use "xolox/vim-misc"
        -- searching
        use "junegunn/fzf"
        use {
            "junegunn/fzf.vim",
            config = require("plugins.configs.fzf"),
            run = function()
                vim.fn["fzf#install()"](0)
            end
        }
        -- explorer
        use "kyazdani42/nvim-web-devicons"
        use {
            "kyazdani42/nvim-tree.lua",
            config = require("plugins.configs.nvimtree"),
            requires = "kyazdani42/nvim-web-devicons"
        }
        -- git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("gitsigns").setup()
            end
        }

        use "tpope/vim-rhubarb"
        use "tpope/vim-fugitive"

        -- lsp
        use "neovim/nvim-lspconfig"
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup({})
            end
        }
        use {"ray-x/lsp_signature.nvim",
	    config = require("plugins.configs.lspsignature")
        }
        use "jose-elias-alvarez/null-ls.nvim"
        use "jose-elias-alvarez/nvim-lsp-ts-utils"

        -- completion
        use {
            "hrsh7th/nvim-cmp",
            config = require("plugins.configs.cmp"),
            requires = {
                "hrsh7th/cmp-buffer", --
                -- 'ray-x/cmp-treesitter', --
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-emoji",
                "onsails/lspkind-nvim"
            }
        }
        -- languages
        use "fatih/vim-go"
        use "pangloss/vim-javascript"
        use "leafgarland/typescript-vim"
        use "peitalin/vim-jsx-typescript"
        use "styled-components/vim-styled-components"
        use "mattn/emmet-vim"
        use "elixir-editors/vim-elixir"
        use "chrisbra/csv.vim"
        use "ellisonleao/glow.nvim"
        -- snippets
        use "L3MON4D3/LuaSnip"
        use {
	    "saadparwaiz1/cmp_luasnip",
	    config = require("plugins.configs.luasnip")
        }
        -- app integrations
        use "robbyrussell/oh-my-zsh"
        use "christoomey/vim-tmux-navigator"
        -- motions
        use "wellle/targets.vim"
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        use "tpope/vim-surround"
        use "jiangmiao/auto-pairs"
        -- patches
        -- cursorhold: https://github.com/neovim/neovim/issues/12587
        use "antoinemadec/FixCursorHold.nvim"
        -- other
        use "editorconfig/editorconfig-vim"
        use "AndrewRadev/switch.vim" -- flipping values like booleans
        use "simrat39/symbols-outline.nvim"
        -- 'nathanaelkane/vim-indent-guides'
        use "yuttie/comfortable-motion.vim"
        use "easymotion/vim-easymotion"
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }
        use "majutsushi/tagbar"
        use "liuchengxu/vim-which-key"
        use "vimwiki/vimwiki"
        use "rhysd/committia.vim"
        use {
	    "nvim-treesitter/nvim-treesitter",
	    run = ":TSUpdate",
	    config = require("plugins.configs.treesitter")
        }
        use "nvim-treesitter/playground"
        use "sunjon/shade.nvim"
        use {
	    "nvim-telescope/telescope.nvim",
	    requires = {{"nvim-lua/plenary.nvim"}}
        }
        use {"rcarriga/nvim-notify"}
        use {
            "glacambre/firenvim",
            config = require("plugins.configs.fire"),
            run = function()
                vim.fn["firenvim#install"](0)
            end
        }
        -- personal ones
        use {
	    "~/vimlibs/pulls",
	    config = require("plugins.configs.pulls")
        }
    end
)

