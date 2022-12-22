local signature_setup = require("plugins.configs.lspsignature").signature_setup

require("lspconfig").pylsp.setup({
	on_attach = function(client, bufnr)
		require("lsp_signature").on_attach(signature_setup, bufnr)
	end,
})
