require("paint").setup({
	highlights = {
		{
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%-%s*(@%w+)",
			hl = "Constant",
		},
		{
			filter = { filetype = "markdown" },
			pattern = "%*.-%*", -- *foo*
			hl = "Title",
		},
		{
			filter = { filetype = "markdown" },
			pattern = "%*%*.-%*%*", -- **foo**
			hl = "Error",
		},
		{
			filter = { filetype = "markdown" },
			pattern = "%s_.-_", --_foo_
			hl = "MoreMsg",
		},
		{
			filter = { filetype = "markdown" },
			pattern = "%s%`.-%`", -- `foo`
			hl = "Keyword",
		},
		{
			filter = { filetype = "markdown" },
			pattern = "%`%`%`.*", -- ```foo<CR>...<CR>```
			hl = "MoreMsg",
		},
	},
})
