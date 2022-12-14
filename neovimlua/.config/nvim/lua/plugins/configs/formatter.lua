-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands.
--
-- This module has a dumb of util commands that I prefer to just go in and
-- copy the code and put it back here, so I can use the direct vim api for
-- things like getting filenames.
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				-- if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") == "special.lua" then
				-- 	return nil
				-- end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0), true),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		-- ["*"] = {
		--   -- "formatter.filetypes.any" defines default configurations for any
		--   -- filetype
		--   require("formatter.filetypes.any").remove_trailing_whitespace
		-- }
	},
})
