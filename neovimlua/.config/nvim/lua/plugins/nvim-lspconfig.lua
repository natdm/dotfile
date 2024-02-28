return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- local lspconfig = require("lspconfig")
		local mason = require("mason")

		mason.setup()
	end,
}
