require("lspconfig").yamlls.setup({
	settings = {
		yaml = {
			schemas = { kubernetes = "/*.yaml" },
			schemaDownload = { enable = true },
			validate = true,
		},
	},
})
