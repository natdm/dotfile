local ls = require('luasnip')

ls.config.set_config({
    -- treesitter-hl has 100, use something higher (default is 200).
    -- ext_base_prio = 300,
    -- minimal increase in priority.
    -- ext_prio_increase = 1,
    enable_autosnippets = true,
    history = true,
    updateevents = "TextChanged,TextChangedI"
})

-- some shorthands...
local sn = ls.snippet_node
local i = ls.insert_node

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
    fmt = fmt or "%Y-%m-%d( "
    return sn(nil, i(1, os.date(fmt)))
end

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
local go_snippets = require('snippets.go')
local all_snippets = require('snippets.all')
local lua_snippets = require("snippets.lua")
local md_snippets = require("snippets.markdown")
local ts_snippets = require("snippets.typescript")
local vw_snippets = require("snippets.vimwiki")

ls.add_snippets("all", all_snippets.snippets)
ls.add_snippets("all", all_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("go", go_snippets.snippets)
ls.add_snippets("go", go_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("lua", lua_snippets.snippets)
ls.add_snippets("lua", lua_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("markdown", md_snippets.snippets)
ls.add_snippets("markdown", md_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("typescript", ts_snippets.snippets)
ls.add_snippets("typescript", ts_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("vimwiki", vw_snippets.snippets)
ls.add_snippets("vimwiki", vw_snippets.snippets, { type = "autosnippets" })
