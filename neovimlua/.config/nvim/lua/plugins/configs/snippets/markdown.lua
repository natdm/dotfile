local ls = require('luasnip')

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	snippets = {
		s("suggestion", {
			t("**suggestion**: "), i(1, "suggestion.."), t({"", ""}), i(0)
		}),
		s("issue", {
			t("**issue**: "), i(1, "issue.."), t({"", ""}), i(0)
		}),
		s("praise", {
			t("**praise**: "), i(1, "praise.."), t({"", ""}), i(0)
		}),
		s("nitpick", {
			t("**nitpick**: "), i(1, "nitpick.."), t({"", ""}), i(0)
		}),
		s("question", {
			t("**question**: "), i(1, "question.."), t({"", ""}), i(0)
		}),
		s("thought", {
			t("**thought**: "), i(1, "thought.."), t({"", ""}), i(0)
		}),
		s("typo", {
			t("**typo**: "), i(1, "typo.."), t({"", ""}), i(0)
		}),
	},
	auto_snippets = {
	}
}
