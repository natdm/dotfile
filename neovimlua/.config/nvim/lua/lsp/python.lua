require("lspconfig").pyright.setup({
	on_attach = function(client, bufnr)
		vim.lsp.buf.inlay_hint(bufnr, true)
	end,
})
