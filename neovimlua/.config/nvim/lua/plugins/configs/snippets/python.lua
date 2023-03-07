local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.expand_conditions")

return {
	snippets = {
		s(
			"main",
			fmt(
				[[
			def main() -> None:
				{}


			if __name__ == "__main__":
				main()
			]],
				{ i(0, "pass") }
			)
		),
		s(
			"name",
			fmt(
				[[
		if __name__ == "__main__":
			{}
		]],
				{ i(1) }
			)
		),
	},
	auto_snippets = {
		s(
			"test",
			d(1, function()
				return sn(
					nil,
					fmt(
						[[
								def test_{}(self):
									{}
							]],
						{ i(1, "name"), i(0) }
					)
				)
			end),
			{
				condition = function()
					local path = vim.fn.expand("%:p")
					local is_py = vim.bo.filetype == "python"

					local line_num = vim.api.nvim__buf_stats(0).current_lnum
					local content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)
					local is_empty = content[1]:match("^%s+")
					local is_test_file = string.find(path, "/test_") ~= nil
					return is_test_file and is_py and is_empty
				end,
			}
		),
	},
}
