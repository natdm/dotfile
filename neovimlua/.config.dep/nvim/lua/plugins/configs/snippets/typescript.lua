local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	snippets = {
		s("kv", {
			i(1),
			t(": ${"),
			rep(1),
			t("}"),
			i(0),
		}),
		s("for", {
			t("for (let "),
			i(1, "var"),
			t(" = 0; "),
			rep(1),
			t(" < "),
			i(2, "len"),
			t("; "),
			rep(1),
			t({ "++) {", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
		s("async", {
			t("async function "),
			i(1),
			t("("),
			i(0),
			t({ ") {", "\t", "}" }),
		}),
		s({ trig = "import proxy", docstring = "import activities proxy" }, {
			t("import { activities } from '@atomicfi/temporal-activities-proxy'"),
		}),
		s({ trig = "require proxy", docstring = "requrie activities proxy" }, {
			t("const { activities } = require('@atomicfi/temporal-activities-proxy')"),
		}),
		s({ trig = "import db", docstring = "import db proxy for temporal" }, {
			t("import { models } from '@atomicfi/temporal-database'"),
		}),
		s({ trig = "require db", docstring = "require db proxy for temporal" }, {
			t("const { models } = require('@atomicfi/temporal-database')"),
		}),
	},
}
