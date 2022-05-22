local ls = require("luasnip")

ls.config.set_config({
	-- treesitter-hl has 100, use something higher (default is 200).
	-- ext_base_prio = 300,
	-- minimal increase in priority.
	-- ext_prio_increase = 1,
	enable_autosnippets = true,
	history = true,
	-- ext_opts = {
	-- [require("luasnip.util.types").choiceNode] = {
	--  active = {
	--   virt_text = { { "V" } }
	--  }
	-- }
	-- }
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
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")
local rep = require("luasnip.extras").rep

local date = function()
	return { os.date("%Y-%m-%d") }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

return {
	snippets = {
		s("bash", f(bash, {}, { user_args = { "ls" } })),
		s("date", f(date, {}, {})),
	},
	auto_snippets = {

		s("autotrigger", {
			t("autosnippet"),
		}),
		s("testchoice", {
			t("I choose "),
			c(1, { t("this"), t("that") }),
			t(".."),
			i(0),
		}),
	},
}
