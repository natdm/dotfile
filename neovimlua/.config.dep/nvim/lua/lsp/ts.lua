local util = require("lspconfig/util")
local lsputils = require("lsp.all")

require("lspconfig").tsserver.setup({
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	init_options = {
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = "non-relative",
		},
	},
	on_attach = function(client, bufnr)
		-- this should do some inlayHintProvider stuff
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		lsputils.on_attach(client, bufnr)
	end,
})

require("lspconfig").eslint.setup({
	on_attach = function(client, bufnr)
		-- fix any ESLint issues before executing the save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
