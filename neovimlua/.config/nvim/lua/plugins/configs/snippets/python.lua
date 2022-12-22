local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	snippets = {
		s("__main", { t('if __name__ == "__main__":') }),
	},
	auto_snippets = {},
}
