local cmd = vim.cmd

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
cmd([[
augroup AutoSave
  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup end
]])

-- Highlight whatever was yanked, very briefly.
cmd([[
augroup LuaHighlight
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
]])

-- Show a mark on any lines that are at the curren character count (81 at the moment).
cmd([[
augroup LongLines
  au!
  hi ExtendedCol ctermfg=15 ctermbg=1 guifg=#bf616a
  call matchadd('ExtendedCol', '\%81v', 1000)
augroup END
]])

-- make go have less whitespace, for god sake
cmd([[
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
au! BufWritePre *_test.go TestFileRace
]])


cmd([[
command TestFileRace :lua TestFileRace()
command TestAllRace :lua TestAllRace()
command TestSummary :lua TestSummary()
]])


