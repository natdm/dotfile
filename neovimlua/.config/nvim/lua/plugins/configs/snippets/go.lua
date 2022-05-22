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
local rep = require("luasnip.extras").rep
local fmt = require('luasnip.extras.fmt').fmt
local conds = require("luasnip.extras.expand_conditions")

local get_node_text = vim.treesitter.get_node_text

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

-- NOTE: if you can change the query below to this, you'll get more of the
-- function to use
-- (method_declaration name: (_) @name parameters: (_) @params result: (_) @id)
-- (function_declaration name: (_) @name parameters: (_) @params result: (_) @id)
-- (func_literal result: (_) @id)

vim.treesitter.set_query(
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
    return t "0"
  elseif text == "error" then
    if info then
      info.index = info.index + 1

      return c(info.index, {
        t(string.format('fmt.Errorf("error in %s: %%w", %s)', info.func_name, info.err_name)),
        t(info.err_name),
      })
    else
      return t "err"
    end
  elseif text == "bool" then
    return t "false"
  elseif text == "string" then
    return t '""'
  elseif string.find(text, "*", 1, true) then
    return t "nil"
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
        table.insert(result, t { ", " })
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

  local query = vim.treesitter.get_query("go", "LuaSnip_Result")
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local go_ret_vals = function(args)
  return snippet_from_nodes(
    nil,
    go_result_type {
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    }
  )
end

-- local same = function(index)
--   return f(function(args)
--     return args[1]
--   end, { index })
-- end

vim.treesitter.set_query(
	"go", "Go_Func_Name",
	[[ [
 (function_declaration name: (identifier) @name)
 (method_declaration receiver: (parameter_list (parameter_declaration type: (type_identifier) @typ)) name: (field_identifier) @name)
] ]]
)

-- NOTE: This is in the future to get the name and context var of
-- a method or func that has context in it. To be used for completing
-- things like spans.
vim.treesitter.set_query("go", "Go_Context", [[ [
(function_declaration 
  name: (_) @name 
  parameters: (parameter_list 
		(parameter_declaration 
		  name: (_) @ctx 
		  type: (_) @type)
		) 
  (#eq? @type "context.Context")
)
(method_declaration 
  name: (_) @name 
  parameters: (parameter_list 
		(parameter_declaration 
		  name: (_) @ctx 
		  type: (_) @type)
		) 
  (#eq? @type "context.Context")
)
] ]]
)

function _G.go_func_name()
  -- local cursor_node = ts_utils.get_node_at_cursor()
  -- local scope = ts_locals.get_scope_tree(cursor_node, 0)
  --
  -- local function_node
  -- for _, v in ipairs(scope) do
  --   if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
  --     function_node = v
  --     break
  --   end
  -- end

  local query = vim.treesitter.get_query("go", "Go_Func_Name")
  for _, node in query:iter_captures(nil, 0) do
	  print(vim.inspect(node))
  end
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

local test_snippet = function(a, snip, opts)
	-- print("a")
	-- print(vim.inspect(a))
	-- print("snip")
	local parser = vim.treesitter.get_parser(0, "go")
	local tstree = parser:parse()
	-- lines is the whole dang file..
	local lines = vim.treesitter.query.get_node_text(tstree[1]:root(), 1)
	-- for _, node in ipairs(snip.nodes) do
	--     print(vim.inspect(node.mark:pos_begin()))
	--     print(vim.inspect(node.mark:pos_end()))
	--     local tsnode = tstree[1]:root():named_descendant_for_range(
	--         node.mark:pos_begin(1),
	--         node.mark:pos_begin(2),
	--         node.mark:pos_end(1),
	--         node.mark:pos_end(2)
	--     )
	--     while tsnode ~= nil do
	-- 	    print(tsnode:type())
	-- 	    tsnode = tsnode:parent()
	--     end
	-- end
	-- print("c")
	-- print(vim.inspect(cc))
	print("done")
end

local test_dynamic_node = function(pos)
  return d(pos, function ()
    -- https://youtu.be/KtQZRAkgLqo?t=1304
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(0, 0, line+1, false)
    -- iterate backwards trying to find the nearest function
    local method_match = "func%s%((%a+)%s(%a+)%)%s(%a+)%((%a+)%scontext.Context"
    local func_match = "func%s(%a+)%((%a+)%scontext.Context"
    for ii = #lines, 1, -1 do
      local curr = lines[ii]
      local _, _, alias, typ, name, ctx = string.find(curr, method_match)
      if alias ~= nil then
	      return sn(nil, fmt([[
	      span, ctx := opentracing.StartSpanFromContext({}, "{}.{}")
	      defer span.Finish()
	      ]], {t(ctx), t(typ), t(name)}))
      end
      _, _, name, ctx = string.find(curr, func_match)
      if name ~= nil then
	      return sn(nil, fmt([[
	      span, ctx := opentracing.StartSpanFromContext({}, "{}")
	      defer span.Finish()
	      ]], {t(ctx), t(name)}))
      end

    end
    -- all the lines up to the current cursor
    return sn(nil, t("no-match"))
  end, {})
end

return {
	auto_snippets = {
		s("mthd", c(1, { -- create funcs or methods
			fmt([[
			// {cname} {comment}
			func ({ref} {typ}) {name}({args}) {ret} {{
				{body}
			}}
			]], {
				ref = f(first_char, { 1 }),
				typ = i(1, "Type"),
				name = i(2, "Name"),
				args = i(3),
				ret = i(4, "error"),
				cname = rep(2),
				comment = i(5, "..."),
				body = i(6, "// TODO")
			}),
			fmt([[
			// {cname} {comment}
			func {name}({args}) {ret} {{
				{body}
			}}
			]], {
				name = i(1, "Name"),
				args = i(2),
				ret = i(3, "error"),
				cname = rep(1),
				comment = i(4, "..."),
				body = i(5, "// TODO")
			}),
		}), begin_cond),
		s("cotx", {
			t("ctx context.Context"), i(0)
		}),
		s("wcotx", {
			c(1, {
				t("ctx := context.Background()"),
				t("ctx, cancel := context.WithCancel(ctx)"),
				sn(nil, { -- tab to toggle, shitty
					t("ctx, cancel := context.WithTimeout(ctx, "),
					i(1),
					t(")")
				}),
				sn(nil, {
					t("ctx, cancel := context.WithDeadline(ctx, "),
					i(1),
					t(")")
				}),
				sn(nil, {
					t("ctx = context.WithValue(ctx, "),
					i(1),
					t(")")
				})
			}),
			i(0)
		}, begin_cond),
		-- for the bottom 2, I like two snippets -- `errn` to make the error cond, then `errf` to start wrapping.
		s("errn", fmt([[
		if {} != nil {{
			return {}
		}}
		]], {i(1, "err"), i(0)})),
		s("errf", {
			t("fmt.Errorf(\""), i(1, "text"), t(": %w\", "), i(2, "err"), t(")"), i(0)
		}),
		s("wfld", {
			c(1, {
				sn(nil, {
					t("WithField(\""), i(1), t("\": "), i(2), t(")"), i(0)
				}),
				sn(nil, {
					t("WithFields(logrus.Fields{"), i(1), t("})"), i(0)
				}),
				sn(nil, {
					t("WithError("), i(1), t(")"), i(0)
				})
			})
		}),
		s("ap=", fmt([[{} = append({}, {})]], { -- appending
			i(1),
			rep(1),
			i(0)
		}), begin_cond),
		s("nok", fmt([[
		if !ok {{
			{}
		}}
		]], i(0)), begin_cond),
		s("rn", {t("return")}, begin_cond),
		    s("efi", { -- this is cool but it seems to have bugs.
		      i(1, { "val" }),
		      t(", "),
		      i(2, { "err" }),
		      t(" := "),
		      i(3, { "f" }),
		      t("("),
		      i(4),
		      t(")"),
		      t { "", "if " },
		      rep(2),
		      t { " != nil {", "\treturn " },
		      d(5, go_ret_vals, { 2, 3 }),
		      t { "", "}" },
		      i(0),
		    }, begin_cond)
	},
	snippets = {
		s("foo", {t("hiya!!"), i(1, "foo"), rep(1), f(test_snippet)}), -- learning how `f` works
  	        s("opentrace", test_dynamic_node(1), begin_cond),
		s({trig="test", dscr="func Test{???}(*testing.T) {...}"}, fmt([[
		func Test{name}(t *testing.T) {{
			{body}
		}}
		]], {
			name = i(1),
			body = i(0)
		})),
		s("subtests", fmt([[
		for {name}, {tc} := range {tests} {{
			t.Run({name2}, func(t *testing.T) {{
				{body}
			}})
		}}
		]], {
			name = i(1, "name"),
			tc = i(2, "tc"),
			tests = i(3, "tests"),
			name2 = rep(1),
			body = i(0)
		})),
		s("kv", fmt([["{}": {}]], { -- "baz": Foo.Bar.Baz
			f(last_word, { 1 }),
			i(1)
		})),
		s({trig="def"}, fmt([[
		defer func() {{
			{}
		}}()
		]], i(0))),
		s({trig="gof"}, fmt([[
		go func() {{
			{}
		}}()
		]], i(0))),
	}
}
