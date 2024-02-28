local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local d = ls.dynamic_node

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
	fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end

return {
	snippets = {
		s("suggestion", {
			t("**suggestion**: "),
			i(1, "suggestion.."),
			t({ "", "" }),
			i(0),
		}),
		s("issue", {
			t("**issue**: "),
			i(1, "issue.."),
			t({ "", "" }),
			i(0),
		}),
		s("praise", {
			t("**praise**: "),
			i(1, "praise.."),
			t({ "", "" }),
			i(0),
		}),
		s("nitpick", {
			t("**nitpick**: "),
			i(1, "nitpick.."),
			t({ "", "" }),
			i(0),
		}),
		s("question", {
			t("**question**: "),
			i(1, "question.."),
			t({ "", "" }),
			i(0),
		}),
		s("thought", {
			t("**thought**: "),
			i(1, "thought.."),
			t({ "", "" }),
			i(0),
		}),
		s("typo", {
			t("**typo**: "),
			i(1, "typo.."),
			t({ "", "" }),
			i(0),
		}),
		s("meta", { --
			t("# "),
			i(1, "name"),
			t({ "", "---", "", "" }), --
			t("**Date**: "),
			d(2, date_input, {}, "%A, %B %d of %Y"),
			t({ "", "", "" }), --
			t("**Tags**: "),
			i(3, "platform-apps"),
			t({ "", "", "" }), --
			t({ "**Author**: Nathan Hyland", "", "---", "", "" }), --
			t({ "## Description", "" }), --
			i(0),
			t({ "", "## Document", "", "" }), --
			t({ "## References", "", "" }), --
		}),
	},
	auto_snippets = {},
}
