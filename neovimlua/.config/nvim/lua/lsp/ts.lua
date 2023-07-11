local util = require("lspconfig/util")
local lsputils = require("lsp.all")

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

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
		-- end inlay hint stuff

		-- require("eslint").setup({
		-- 	bin = "eslint", -- or `eslint_d`
		-- 	code_actions = {
		-- 		enable = true,
		-- 		apply_on_save = {
		-- 			enable = true,
		-- 			types = { "directive", "problem", "suggestion", "layout" },
		-- 		},
		-- 		disable_rule_comment = {
		-- 			enable = true,
		-- 			location = "separate_line", -- or `same_line`
		-- 		},
		-- 	},
		-- 	diagnostics = {
		-- 		enable = true,
		-- 		report_unused_disable_directives = false,
		-- 		run_on = "type", -- or `save`
		-- 	},
		-- })
	end,
	-- settings = {documentFormatting = true},
	-- on_attach = function(client, bufnr)
	-- local ts_utils = require("nvim-lsp-ts-utils")
	-- ts_utils.setup({})
	-- ts_utils.setup_client(client)
	-- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
	-- buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
	-- buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
	-- vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	-- vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	-- vim.cmd("command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()")
	-- vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	-- vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	-- vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	-- vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	-- vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	-- vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
	-- vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
	-- vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
	-- vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	-- buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	-- buf_map(bufnr, "n", "gr", ":LspRename<CR>")
	-- buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
	-- buf_map(bufnr, "n", "K", ":LspHover<CR>")
	-- buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
	-- buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
	-- buf_map(bufnr, "n", "<leader>ca", ":LspCodeAction<CR>")
	-- buf_map(bufnr, "n", "<leader>cra", ":LspRangeCodeAction<CR>")
	-- buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
	-- buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
	-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })")
	-- vim.cmd("command! LspFormatting lua vim.lsp.buf.format({ async = true })")
	-- end,
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
