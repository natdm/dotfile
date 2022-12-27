local signature_setup = require("plugins.configs.lspsignature").signature_setup

require("lspconfig").pyright.setup({
	on_attach = function(client, bufnr)
		require("lsp_signature").on_attach(signature_setup, bufnr)
	end,
})
