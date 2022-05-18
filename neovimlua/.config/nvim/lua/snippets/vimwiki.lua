local ls = require('luasnip')

-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local d = ls.dynamic_node

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
    fmt = fmt or "%Y-%m-%d( "
    return sn(nil, i(1, os.date(fmt)))
end
return {
	snippets = {
		s("meta", { --
		    t("# "), i(1, "name"), t({"", "---", "", ""}), --
		    t("**Date**: "), d(2, date_input, {}, "%A, %B %d of %Y"), t({"", "", ""}), --
		    t("**Tags**: "), i(3, "ciot"), t({"", "", ""}), --
		    t({"**Author**: Nathan Hyland", "", "---", "", ""}), --
		    t({"## Description", ""}), --
		    i(0), t({"", "## Document", "", ""}), --
		    t({"## References", "", ""}) --
		})
	},
	auto_snippets = {
	}
}
