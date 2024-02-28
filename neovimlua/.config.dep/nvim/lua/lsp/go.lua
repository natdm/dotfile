local lsputils = require("lsp.all")

require("lspconfig").gopls.setup({
	on_attach = function(client, bufnr)
		lsputils.on_attach(client, bufnr)
	end,
})
