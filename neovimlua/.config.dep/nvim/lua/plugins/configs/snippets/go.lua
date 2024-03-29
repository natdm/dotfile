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

local get_node_text = vim.treesitter.get_node_text

local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

-- NOTE: if you can change the query below to this, you'll get more of the
-- function to use
-- (method_declaration name: (_) @name parameters: (_) @params result: (_) @id)
-- (function_declaration name: (_) @name parameters: (_) @params result: (_) @id)
-- (func_literal result: (_) @id)

vim.treesitter.query.set(
	"go",
	"LuaSnip_Result",
	[[ [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ] ]]
)

local transform = function(text, info)
	if text == "int" then
		return t("0")
	elseif text == "error" then
		if info then
			info.index = info.index + 1

			return c(info.index, {
				t(string.format('fmt.Errorf("error in %s: %%w", %s)', info.func_name, info.err_name)),
				t(info.err_name),
			})
		else
			return t("err")
		end
	elseif text == "bool" then
		return t("false")
	elseif text == "string" then
		return t('""')
	elseif string.find(text, "*", 1, true) then
		return t("nil")
	end

	return t(text)
end

local handlers = {
	["parameter_list"] = function(node, info)
		local result = {}

		local count = node:named_child_count()
		for idx = 0, count - 1 do
			table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
			if idx ~= count - 1 then
				table.insert(result, t({ ", " }))
			end
		end

		return result
	end,

	["type_identifier"] = function(node, info)
		local text = get_node_text(node, 0)
		return { transform(text, info) }
	end,
}

local function go_result_type(info)
	local cursor_node = ts_utils.get_node_at_cursor()
	local scope = ts_locals.get_scope_tree(cursor_node, 0)

	local function_node
	for _, v in ipairs(scope) do
		if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
			function_node = v
			break
		end
	end

	local query = vim.treesitter.query.get_query("go", "LuaSnip_Result")
	for _, node in query:iter_captures(function_node, 0) do
		if handlers[node:type()] then
			return handlers[node:type()](node, info)
		end
	end
end

local go_ret_vals = function(args)
	return snippet_from_nodes(
		nil,
		go_result_type({
			index = 0,
			err_name = args[1][1],
			func_name = args[2][1],
		})
	)
end

local begin_cond = { condition = conds.line_begin }

-- first_char will get the first character of a string,
-- lowercase it, and return it.
local first_char = function(str)
	return string.sub(string.lower(str[1][1]), 1, 1) or ""
end

-- last_word will get the last word of a call (A.B.Charlie) returns charlie
-- lowercased.
local last_word = function(str)
	local parts = vim.split(str[1][1], ".", true)
	return string.lower(parts[#parts]) or ""
end

local opentrace_span = function(pos)
	return d(pos, function()
		-- https://youtu.be/KtQZRAkgLqo?t=1304
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_get_lines(0, 0, line + 1, false)
		-- iterate backwards trying to find the nearest function
		local method_test = "func%s%((%a+)%s(%a+)%)%s(%a+)%((%a+)%scontext.Context"
		local func_test = "func%s(%a+)%((%a+)%scontext.Context"
		local anon_fn_test = "(%a+) := func%((%a*)%s"
		local echo_func_test = "func%s(%a+)%((%a+)%secho.Context"
		local pkg = ""

		-- get the package first, loop from the start in case there's a comment.
		for _, l in ipairs(lines) do
			local package_test = "^package%s(%a*)"
			_, _, pkg = string.find(l, package_test)
			if pkg ~= nil and pkg ~= "" then
				break
			end
		end

		-- np packge means no span, return nothing.
		if pkg == nil or pkg == "" then
			print("no package")
			return nil
		end

		for ii = #lines, 1, -1 do
			local curr = lines[ii]
			local _, _, _, typ, name, ctx = string.find(curr, method_test)
			-- Check for a method and return the span
			if ctx ~= nil then
				return sn(
					nil,
					fmt(
						[[
	      ctx, span := tracer.Start({}, "{}.{}.{}")
	      defer span.End()
	      ]],
						{ t(ctx), t(pkg), t(typ), t(name) }
					)
				)
			end

			-- check for a function and return the span
			_, _, name, ctx = string.find(curr, func_test)
			if ctx ~= nil then
				return sn(
					nil,
					fmt(
						[[
	      ctx, span := tracer.Start({}, "{}.{}")
	      defer span.End()
	      ]],
						{ t(ctx), t(pkg), t(name) }
					)
				)
			end

			-- check for an Echo function and return the span
			_, _, name, ctx = string.find(curr, echo_func_test)
			if ctx ~= nil then
				return sn(
					nil,
					fmt(
						[[
	      ctx, span := tracer.Start({}.Request().Context(), "{}.{}")
	      defer span.End()
	      ]],
						{ t(ctx), t(pkg), t(name) }
					)
				)
			end

			-- check for anonymous functions
			_, _, name, ctx = string.find(curr, anon_fn_test)
			if ctx ~= nil then
				return sn(
					nil,
					fmt(
						[[
	      ctx, span := tracer.Start({}, "{}.{}")
	      defer span.End()
	      ]],
						{ t(ctx), t(pkg), t(name) }
					)
				)
			end
		end
		-- all the lines up to the current cursor
		return sn(nil, t("no-match"))
	end, {})
end

return {
	auto_snippets = {
		s(
			"mthd",
			c(1, { -- create funcs or methods
				fmt(
					[[
			func ({ref} {typ}) {name}({args}) {ret} {{
				{body}
			}}
			]],
					{
						ref = f(first_char, { 1 }),
						typ = i(1, "Type"),
						name = i(2, "Name"),
						args = i(3),
						ret = i(4, "error"),
						body = i(5, "// TODO"),
					}
				),
				fmt(
					[[
			func {name}({args}) {ret} {{
				{body}
			}}
			]],
					{
						name = i(1, "Name"),
						args = i(2),
						ret = i(3, "error"),
						body = i(4, "// TODO"),
					}
				),
			}),
			begin_cond
		),
		s("cotx", {
			t("ctx context.Context"),
			i(0),
		}),
		s("wcotx", {
			c(1, {
				t("ctx := context.Background()"),
				t("ctx, cancel := context.WithCancel(ctx)"),
				sn(nil, { -- tab to toggle, shitty
					t("ctx, cancel := context.WithTimeout(ctx, "),
					i(1),
					t(")"),
				}),
				sn(nil, {
					t("ctx, cancel := context.WithDeadline(ctx, "),
					i(1),
					t(")"),
				}),
				sn(nil, {
					t("ctx = context.WithValue(ctx, "),
					i(1),
					t(")"),
				}),
			}),
			i(0),
		}, begin_cond),
		-- for the bottom 2, I like two snippets -- `errn` to make the error cond, then `errf` to start wrapping.
		s(
			"errn",
			fmt(
				[[
		if {} != nil {{
			return {}
		}}
		]],
				{ i(1, "err"), i(0) }
			)
		),
		s("errf", {
			t('fmt.Errorf("'),
			i(1, "text"),
			t(': %w", '),
			i(2, "err"),
			t(")"),
			i(0),
		}),
		s("wfld", {
			c(1, {
				sn(nil, {
					t('WithField("'),
					i(1),
					t('": '),
					i(2),
					t(")"),
					i(0),
				}),
				sn(nil, {
					t("WithFields(logrus.Fields{"),
					i(1),
					t("})"),
					i(0),
				}),
				sn(nil, {
					t("WithError("),
					i(1),
					t(")"),
					i(0),
				}),
			}),
		}),
		s(
			"ap=",
			fmt([[{} = append({}, {})]], { -- appending
				i(1),
				rep(1),
				i(0),
			}),
			begin_cond
		),
		s(
			"nok",
			fmt(
				[[
		if !ok {{
			{}
		}}
		]],
				i(0)
			),
			begin_cond
		),
		s("rn", { t("return") }, begin_cond),
		s("efi", { -- this is cool but it seems to have bugs.
			i(1, { "val" }),
			t(", "),
			i(2, { "err" }),
			t(" := "),
			i(3, { "f" }),
			t("("),
			i(4),
			t(")"),
			t({ "", "if " }),
			rep(2),
			t({ " != nil {", "\treturn " }),
			d(5, go_ret_vals, { 2, 3 }),
			t({ "", "}" }),
			i(0),
		}, begin_cond),
	},
	snippets = {
		s("handler", { t("w http.ResponseWriter, r *http.Request") }),
		s(
			"forfn",
			fmt(
				[[
		for _, {} := range {} {{
			{}({})
		}}
		]],
				{ i(1, "fn"), i(2, "funcs"), rep(1), i(3, "obj") }
			)
		),
		s("debug", { i(1, "entry"), t('.Debug("---'), i(2, "statement"), t({ '---")', "" }), i(0) }),
		s(
			"debugj",
			fmt(
				[[
		bs, _ := json.MarshalIndent({}, "", "\t")
		fmt.Println(string(bs))
		]],
				i(1, "out")
			)
		),
		s("require", t("require, assert := require.New(t), assert.New(t)")),
		s(
			"env",
			fmt(
				[[
		{}, ok := os.LookupEnv({})
		if !ok {{
			{}
		}}
		]],
				{ i(1, "var"), i(2, "env"), i(0) }
			),
			begin_cond
		),
		s("span", opentrace_span(1), begin_cond),
		s(
			{ trig = "test", dscr = "func Test{???}(*testing.T) {...}" },
			fmt(
				[[
		func Test{name}(t *testing.T) {{
			{body}
		}}
		]],
				{
					name = i(1),
					body = i(0),
				}
			)
		),
		s(
			"subtest",
			fmt(
				[[
		t.Run("{}", func(t *testing.T) {{
			{}
			{}
		}})
		]],
				{ i(1, "name"), c(2, { t("t.Parallel()"), t("") }), i(0) }
			)
		),
		s(
			"kv",
			c(1, {
				fmt([[{} = "{}"]], { -- baz = "baz"
					i(1),
					rep(1),
				}),
				fmt([["{}": {}]], { -- "baz": Foo.Bar.Baz
					f(last_word, { 1 }),
					i(1),
				}),
			})
		),
		s(
			{ trig = "def" },
			fmt(
				[[
		defer func() {{
			{}
		}}()
		]],
				i(0)
			)
		),
		s(
			{ trig = "gof" },
			fmt(
				[[
		go func() {{
			{}
		}}()
		]],
				i(0)
			)
		),
	},
}
