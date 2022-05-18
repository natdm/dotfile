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

local get_node_text = vim.treesitter.get_node_text

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

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
        t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
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

local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

vim.treesitter.set_query(
	"go", "Go_Func_Name",
	[[ [
 (function_declaration name: (identifier) @name)
 (method_declaration receiver: (parameter_list (parameter_declaration type: (type_identifier) @typ)) name: (field_identifier) @name)
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
  for _, node in query:iter_captures("function_declaration", 0) do
	  print(vim.inspect(node))

  end
end

return {
	auto_snippets = {
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
		}),
		s("iferr", {
			t({"if err != nil {","\t"}), i(0), t({"","}"})
		}),
		s("errf", {
			t("fmt.Errorf(\""), i(1, "text"), t(": %w\", "), i(2, "err"), t(")"), i(0)
		}),
		s("witherr", {
			t("WithError("), i(1, "err"), t(")"), i(0)
		}),
		s("withfld", {
			t("WithField(\""), i(1, "key"), t("\": "), i(2, "value"), t(")"), i(0)
		}),
	},
	snippets = {
		s("logfn", {})
	--	s("efi", {
	   --  		i(1, { "val" }),
	   --  		", ",
	   --  		i(2, { "err" }),
	   --  		" := ",
	   --  		i(3, { "f" }),
	   --  		"(",
	   --  		i(4),
	   --  		")",
	   --  		t { "", "if " },
	   --  		same(2),
	   --  		t { " != nil {", "\treturn " },
	   --  		d(5, go_ret_vals, { 2, 3 }),
	   --  		t { "", "}" },
	   --  		i(0),
		-- })
	}
}
