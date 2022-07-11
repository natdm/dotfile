local ls = require('luasnip')

ls.config.set_config({
    -- treesitter-hl has 100, use something higher (default is 200).
    -- ext_base_prio = 300,
    -- minimal increase in priority.
    -- ext_prio_increase = 1,
    enable_autosnippets = true,
    history = true,
    -- updateevents = "TextChanged,TextChangedI" -- this seems to not work
})

-- https://github.com/tjdevries/config_manager/blob/e96ce10806cafbd4f3a8ff19729b75342857ce71/xdg_config/nvim/after/plugin/luasnip.lua#L64
-- this is badass, do this
--
local go_snippets = require('plugins.configs.snippets.go')
local all_snippets = require('plugins.configs.snippets.all')
local lua_snippets = require("plugins.configs.snippets.lua")
local md_snippets = require("plugins.configs.snippets.markdown")
local ts_snippets = require("plugins.configs.snippets.typescript")
local vw_snippets = require("plugins.configs.snippets.vimwiki")
require('todo-comments') -- just import, it registers itself

ls.add_snippets("all", all_snippets.snippets)
ls.add_snippets("all", all_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("go", go_snippets.snippets)
ls.add_snippets("go", go_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("lua", lua_snippets.snippets)
ls.add_snippets("lua", lua_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("markdown", md_snippets.snippets)
ls.add_snippets("markdown", md_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("gitcommit", md_snippets.snippets)
ls.add_snippets("gitcommit", md_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("typescript", ts_snippets.snippets)
ls.add_snippets("typescript", ts_snippets.auto_snippets, { type = "autosnippets" })
ls.add_snippets("vimwiki", vw_snippets.snippets)
ls.add_snippets("vimwiki", vw_snippets.snippets, { type = "autosnippets" })

