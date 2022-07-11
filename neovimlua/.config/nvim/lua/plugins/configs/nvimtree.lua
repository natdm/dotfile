local g = vim.g

-- explorer
g.nvim_tree_width = 60

require("nvim-web-devicons").setup({ default = true })
require("nvim-tree").setup({
	renderer = {
		highlight_opened_files = "name",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	actions = { open_file = { quit_on_open = true } },
	diagnostics = { enable = true },
	update_focused_file = {
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		-- update_cwd = true,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},
})
