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

autocmd("BufNewFile,BufRead", {
	pattern = "*.go",
	desc = "make go have less whitespace, for god sake",
	callback = function()
		vim.cmd("setlocal noexpandtab tabstop=2 shiftwidth=2")
		_G.TestFileRace()
	end,
})

autocmd("BufRead", {
	pattern = "*/zsh/functions/*",
	desc = "Update any zsh functions in my personal dotfiles to be shown as bash",
	callback = function()
		vim.cmd("set filetype=bash")
	end,
})

autocmd("BufWritePre", {
	pattern = "*_test.go",
	desc = "test go methods on save",
	callback = function()
		_G.TestFileRace()
	end,
})

-- autocmd("BufWritePost", {
-- 	pattern = "*.js",
-- 	callback = function()
-- 		-- for some reason I can't pass _G.TestFileRace as a param, must br called
-- 		vim.cmd("Prettier")
-- 	end,
-- })

autocmd("BufWritePost", {
	pattern = "*.lua",
	desc = "format lua on save",
	callback = function()
		vim.cmd("FormatWrite")
	end,
})

autocmd("BufWritePost", {
	pattern = "*.py",
	desc = "format python on save",
	callback = function()
		vim.cmd("silent !black -q %")
	end,
})

autocmd("Filetype", {
	pattern = "zsh",
	desc = "bash has better support, so move zsh to bash",
	callback = function()
		vim.cmd("set filetype=bash")
	end,
})
