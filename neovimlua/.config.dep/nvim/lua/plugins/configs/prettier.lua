local prettier = require("prettier")

prettier.setup({
	bin = "prettier", -- or `'prettierd'` (v0.23.3+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	cli_options = {
		tab_width = 2,
		semi = false,
		single_quote = true,
		trailing_comma = "es5",
	},
})
