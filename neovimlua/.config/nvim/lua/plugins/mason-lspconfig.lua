local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
	"williamboman/mason-lspconfig.nvim",
	name = "mason-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = {
			"tsserver",
			"eslint",
			"html",
			"cssls",
			"lua_ls",
		},
		handlers = {
			function(server)
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
				})
			end,
			["tsserver"] = function()
				lspconfig.tsserver.setup({
					capabilities = lsp_capabilities,
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
					},
				})
			end,
		},
	},
}
