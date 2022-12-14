local cmd = vim.cmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight the cursor line and column like crosshairs.
cmd([[
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave, * setlocal nocursorline
  au WinLeave * setlocal nocursorcolumn
augroup end

]])

-- Autosave the buffer pretty much all the time.
-- cmd([[
-- augroup AutoSave
--   autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })
-- augroup end
-- ]])

-- Highlight whatever was yanked, very briefly.
autocmd("TextYankPost", {
	group = augroup("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- Show a mark on any lines that are at the curren character count (81 at the moment).
cmd([[
augroup LongLines
  au!
  hi ExtendedCol ctermfg=15 ctermbg=1 guifg=#bf616a
  call matchadd('ExtendedCol', '\%81v', 1000)
augroup END
]])

-- make go have less whitespace, for god sake

autocmd("BufNewFile,BufRead", {
	pattern = "*.go",
	callback = function()
		vim.cmd("setlocal noexpandtab tabstop=2 shiftwidth=2")
		_G.TestFileRace()
	end,
})

autocmd("BufWritePre", {
	pattern = "*_test.go",
	callback = function()
		-- for some reason I can't pass _G.TestFileRace as a param, must br called
		_G.TestFileRace()
	end,
})

autocmd("BufWritePost", {
	pattern = "*.js",
	callback = function()
		-- for some reason I can't pass _G.TestFileRace as a param, must br called
		vim.cmd("Prettier")
	end,
})

autocmd("BufWritePost", {
	pattern = "*.lua",
	callback = function()
		vim.cmd("FormatWrite")
	end,
})

autocmd("Filetype", {
	pattern = "zsh", -- bash has better support, so move zsh to bash
	callback = function()
		vim.cmd("set filetype=bash")
	end,
})

autocmd("BufRead", {
	pattern = "*.cql", -- for Cassandra queries
	callback = function()
		vim.cmd("set filetype=sql")
	end,
})

-- Reset a zsh filetype to bash, since it's what I use more often
-- cmd([[
-- autocmd Filetype zsh set filetype=bash
-- ]])

local set_bash_elixir_script_ft = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 0, false)
	if string.find(lines[1], "elixir") then
		vim.cmd("set filetype=elixir")
	end
end

-- if the bash script has an elixir exec, set the filetype to elixir
-- This could be extended to different filetypes
autocmd("BufNewFile,BufRead", {
	group = augroup("bash_elixir", {}),
	pattern = "*.sh",
	callback = set_bash_elixir_script_ft,
})

cmd([[
command TestFileRace :lua TestFileRace()
command TestAllRace :lua TestAllRace()
command TestSummary :lua TestSummary()
]])
