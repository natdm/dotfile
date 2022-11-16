local null_ls = require("null-ls")

require("null-ls").setup({
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({ async = true })<CR>")

			-- format on save
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
		end

		if client.server_capabilities.documentRangeFormattingProvider then
			vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_format({ async = true })<CR>")
		end
	end,
	-- on_attach = function(client, bufnr)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
	-- 				vim.lsp.buf.formatting_seq_sync()
	-- 			end,
	-- 		})
	-- 	end
	-- end,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
		null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
		null_ls.builtins.formatting.prettier, -- prettier, eslint, eslint_d, or prettierd
		null_ls.builtins.completion.spell,
	},
})
