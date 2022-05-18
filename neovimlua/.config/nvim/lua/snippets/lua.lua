local ls = require('luasnip')

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	snippets = {
		s("inspect", {t("print(vim.inspect("), i(1), t("))"), i(0)})
	},
	auto_snippets = {}
}
