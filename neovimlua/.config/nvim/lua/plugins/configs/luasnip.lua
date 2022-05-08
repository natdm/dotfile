local ls = require('luasnip')

ls.config.set_config({
    -- treesitter-hl has 100, use something higher (default is 200).
    -- ext_base_prio = 300,
    -- minimal increase in priority.
    -- ext_prio_increase = 1,
    enable_autosnippets = true
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
local l = require('luasnip.extras').lambda
local r = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require('luasnip.util.types')
local conds = require('luasnip.extras.expand_conditions')
local rep = require("luasnip.extras").rep

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
    fmt = fmt or "%Y-%m-%d( "
    return sn(nil, i(1, os.date(fmt)))
end

local go_snippets = require('snippets.go')

-- local ts_locals = require 'nvim-treesitter.locals'
-- local ts_utils = require 'nvim-treesitter.ts_utils'
-- local get_node_text = vim.treesitter.get_node_text

-- local function get_module(args, snip, old_state, initial_text)
--     local cursor_node = ts_utils.get_node_at_cursor()
--     local scope = ts_locals.get_scope_tree(cursor_node, 0)
--     local query = vim.treesitter.get_query(" )elixir", "@definition.type")
--     print(vim.inspect("query " .. query))
--     print(vim.inspect("scope " .. scope))
--     -- for id, node in query:iter_captures(function_node, 0) do if handlers[node:type()] then return handlers[node:type()](node, info) end end
-- end
--
-- function _G.GetModule()
--     get_module()
-- end

-- https://github.com/tjdevries/config_manager/blob/e96ce10806cafbd4f3a8ff19729b75342857ce71/xdg_config/nvim/after/plugin/luasnip.lua#L64
-- this is badass, do this
--
ls.add_snippets("all", {
	s("foo", {t("bar"), i(0)})
})
ls.add_snippets("go", go_snippets)
ls.snippets = {
	lua = {
		s("inspect", {t("print(vim.inspect("), i(1), t("))"), i(0)})
	},
	markdown = {
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
	typescript = {
		s("for",{
			t("for (let "),
			i(1, "var"),
			t(" = 0; "),
			rep(1),
			t(" < "),
			i(2, "len"),
			t("; "),
			r(1),
			t({"++) {","\t"}),
			i(0),
			t({"", "}"})

		}),
		s("pcom", {
			t("export default class "), 
			i(1, "ComponentName"), 
			t(" extends pulumi.ComponentResource {"), 
			t({"", "\tconstructor(componentOpts?: pulumi.ComponentResourceOptions) {", "\t\tsuper('pkg:index:"}),
			rep(1), 
			t("', '"), 
			i(2, "short-name"), 
			t({"', {}, componentOpts);","\t\t"}),
			i(0),
			t({"", "\t}", "}"})
		}),
		s("iface", {
			t("export interface "), 
			i(1, "InterfaceName"), 
			t({" {", "\t"}),
			i(0),
			t({"", "}"})
		}),
		s("ifaced", {
			t("export default interface "), 
			i(1, "InterfaceName"), 
			t({" {", "\t"}),
			i(0),
			t({"", "}"})
		})
	},
    vimwiki = {
        s("meta", { --
            t("# "), i(1, "name"), t({"", "---", "", ""}), --
            t("**Date**: "), d(2, date_input, {}, "%A, %B %d of %Y"), t({"", "", ""}), --
            t("**Tags**: "), i(3, "ciot"), t({"", "", ""}), --
            t({"**Author**: Nathan Hyland", "", "---", "", ""}), --
            t({"## Description", ""}), --
            i(0), t({"", "## Document", "", ""}), --
            t({"## References", "", ""}) --
        })
    }
}

ls.autosnippets = { --
    all = {s("autotrigger", {t("autosnippet")})}
}
