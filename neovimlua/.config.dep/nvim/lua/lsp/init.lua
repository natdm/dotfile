-- require("lsp.lua")
-- require("lsp.python")
-- require("lsp.elixir")
-- require("lsp.efm")
-- require("lsp.go")
-- require("lsp.ts")
-- require("lsp.bashls")
-- require("lsp.markdown")
-- require("lsp.yamlls")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "eslint", "tsserver" },
})

require("lsp.lua")
require("lsp.go")
require("lsp.ts")
require("lsp.scala")
