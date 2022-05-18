local ls = require('luasnip')

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	snippets = {
		s("req", fmt([[local {} = require "{}"]], { f(function(import_name)
			local parts = vim.split(import_name[1][1], ".", true)
      return parts[#parts] or ""
		end, { 1  }), i(1) })),
		s("inspect", {t("print(vim.inspect("), i(1), t("))"), i(0)})
	},
	auto_snippets = {}
}
