local M = {}

function M.on_attach(client, bufnr)
	-- disable the disgnostics inline. This is all because of typescript.. f you TS.
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
	})
	-- -- show a float for the diagnostics on the current line
	-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
	-- 	callback = function()
	-- 		if vim.lsp.buf.server_ready() then
	-- 			vim.diagnostic.open_float()
	-- 		end
	-- 	end,
	-- })

	-- if the server allows inlay hints, show them, but only on insert mode since they tend to be annoying
	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	-- 		callback = function()
	-- 			vim.lsp.buf.inlay_hint(0, true)
	-- 		end,
	-- 	})
	-- 	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	-- 		callback = function()
	-- 			vim.lsp.buf.inlay_hint(0, false)
	-- 		end,
	-- 	})
	-- end
end

return M
