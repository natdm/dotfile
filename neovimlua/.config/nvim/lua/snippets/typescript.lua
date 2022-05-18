local ls = require('luasnip')

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	snippets = {
		s("for",{
			t("for (let "),
			i(1, "var"),
			t(" = 0; "),
			rep(1),
			t(" < "),
			i(2, "len"),
			t("; "),
			rep(1),
			t({"++) {","\t"}),
			i(0),
			t({"", "}"})

		}),
	},
	auto_snippets = {}
}
