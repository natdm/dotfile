local ls = require("luasnip")

ls.config.set_config({
	-- treesitter-hl has 100, use something higher (default is 200).
	-- ext_base_prio = 300,
	-- minimal increase in priority.
	-- ext_prio_increase = 1,
	enable_autosnippets = true,
})

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local snippet_from_nodes = ls.sn -- is this different than sn??
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.expand_conditions")

return {
	auto_snippets = {
		s(
			"::",
			c(1, {
				fmt([[{{:ok, {}}} = {}]], { i(1, "pid"), i(0) }),
				fmt([[{{:noreply, {}}} = {}]], { i(1, "state"), i(0) }),
			})
		),
	},
	snippets = {},
}
