local map = vim.api.nvim_set_keymap
local g = vim.g
local cmd = vim.cmd

-- helper functions
local function nmap(pattern, action)
	local options = {}
	map("n", pattern, action, options)
end

local function nmapsl(pattern, action)
	local options = { noremap = true, silent = true }
	map("n", "<leader>" .. pattern, action, options)
end

local function nmaps(pattern, action)
	local options = { noremap = true, silent = true }
	map("n", pattern, action, options)
end

local function nmapl(pattern, action)
	local options = { noremap = true }
	map("n", "<leader>" .. pattern, action, options)
end

local function imap(pattern, action)
	local options = { noremap = true }
	map("i", pattern, action, options)
end

local function vmap(pattern, action)
	local options = { noremap = true }
	map("v", pattern, action, options)
end

local function vmapsl(pattern, action)
	local options = { noremap = true, silent = true }
	map("v", "<leader>" .. pattern, action, options)
end

local function vmapl(pattern, action)
	local options = { noremap = true }
	map("v", "<leader>" .. pattern, action, options)
end
-- the next two lines are equivalent to these two:
-- nnoremap <SPACE> <Nop>
-- let mapleader=" "
nmap("<Space>", "")
g.mapleader = " "

nmap("<C-s>", "<cmd> lua Sig()<CR>")
nmap("<C-c>", ":cclo<CR>")

nmap("s", "<Plug>(easymotion-overwin-f)")

nmapsl("fx", ":set hlsearch!<CR>")

-- keep search resuls in the center of the screen. Thanks Primagen
-- n(ext)zz(center cursor)zv(open folds if any)
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
-- [c and ]c go to next diff sections, with zz to center
nmap("]c", "]czz")
nmap("[c", "[czz")

-- a better way to collapse lines
nmap("J", "mzJ`z")

-- moving texts around, and also obey indentation rules.. which is awesome
-- This is magic to me, but here is the video: https://www.youtube.com/watch?v=hSHATqh8svM
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- save some common breakpoints for undo
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap("!", "!<c-g>u")
imap("?", "?<c-g>u")

-- stay in indent mode after indenting
-- normal >/< mapping only does once and exits visual
vmap(">", ">gv")
vmap("<", "<gv")

-- file explorer
nmaps("t", ":NvimTreeToggle<CR>")

-- prev/next diff and center
nmapl("hh", '<cmd>lua require"gitsigns.actions".next_hunk()<CR>zz')
nmapl("hH", '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>zz')
nmapl("mir", ":CellularAutomaton make_it_rain<CR>")

-- this could be written better, they have examples for it in gitsigns
-- but it works fine.
nmapl("hp", "<cmd>Gitsigns preview_hunk<CR>")
-- search for files within repo
nmapl("ff", ":Files<CR>")
nmapl("fh", ":History<CR>")
-- search for buffers
nmapl("fu", ":Buffers<CR>")
-- search commits for buffer
nmapl("fb", ":BCommits<CR>")
-- search commits
nmapl("fc", ":Commits<CR>")
-- search git files
nmapl("fg", ":GFiles<CR>")
-- search git files that have changed
nmapl("fG", ":GFiles?<CR>")
-- search lines within a file
nmapl("fl", ":BLines<CR>")
-- search for anything with fzf
nmapl("fz", ":FZF<CR>")
-- this ripgrep is basic and requires more filtering. All hidden files, names
-- of files, etc, are searched
nmapl("fr", ":Rg<CR>")
-- Ripgrep looking at all lines in all files, including hidden, but exclude
-- file names from search
nmapl("fa", ":Ag<CR>")
nmapl("fm", ":Marks<CR>")

nmapsl("rc", ":tabedit /.dotfile/neovimlua/.config/nvim/init.lua<CR>")

nmapsl("bc", 'let @+ = expand("%")<CR>')
nmapsl("u !", "bcopy < uuidgen<CR>")
-- resizing.. allow range one day

nmapsl("rV", ':exe "vertical resize +10"<CR>')
nmapsl("rv", ':exe "vertical resize -10"<CR>')
nmapsl("rH", ':exe "resize " . (winheight(0) * 3/2)<CR>')
nmapsl("rh", ':exe "resize " . (winheight(0) * 2/3)<CR>')

nmapsl("tn", ":tabnew<CR>")
nmapsl("tx", ":tabclose<CR>")
nmapsl("ts", ":tab split<CR> ")

-- Breakout split in to new tab -- commented out since I should just learn it.
-- nmapsl("tb", "<C-W>T")

-- window splits
nmapsl("wsh", ":topleft vnew<CR><ESC>")
nmapsl("wsj", ":botright new<CR><ESC>")
nmapsl("wsk", ":topleft new<CR><ESC>")
nmapsl("wsl", ":botright vnew<CR><ESC>")

-- buffer splits
nmapsl("bsh", ":leftabove vnew<CR><ESC>")
nmapsl("bsj", ":rightbelow new<CR><ESC>")
nmapsl("bsk", ":leftabove new<CR><ESC>")
nmapsl("bsl", ":rightbelow vnew<CR><ESC>")

nmapsl("bf", ":BufOnly<CR> ")

-- Paste and don't yank the underlying buffer, overriding default `p`
vmap("p", '"_dP')
vmap("p", '"_dP')

nmap("H", "^")
nmap("L", "$")
vmap("H", "^")
vmap("L", "$")

-- copy the current buffer path
cmd("command! CopyBufferPath let @+ = expand('%:p')")
-- same as above, except it adds the line number
cmd('command! CopyBufferPathL let @+ = expand(\'%:p\') . ":" . ("" . line(".") + 1)')

nmapsl("ybp", ":CopyBufferPath<CR>")
nmapsl("ybl", ":CopyBufferPathL<CR>")

nmapl("cb", ":!open % -a Google\\ Chrome<CR>")

-- lsp-specific settings
nmap("gf", "<cmd>lua vim.lsp.buf.format({ async = false })<CR>")
nmaps("rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
nmaps("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nmaps("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
nmaps("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nmaps("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>") -- no idea why but everyone does `K`
nmap("f", "<cmd>lua vim.diagnostic.open_float()<CR>") -- F for float
nmap("dn", "<cmd>lua vim.diagnostic.goto_prev()<CR>") -- dn: diag next
nmap("dp", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- dp: diag prev

nmapl("rr", "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>:e<CR>")

-- Trouble diagnostics
nmapsl("tq", "<cmd>TroubleToggle quickfix<CR>")
nmapsl("tr", "<cmd>TroubleToggle lsp_references<CR>")
nmapsl("tt", "<cmd>TroubleToggle<CR>")
nmapsl("ta", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- apply a quickfix for neovim (Code Action)

-- Why the hell was C-w ever a thing?
nmaps("<C-h>", "<C-w><C-h>")
nmaps("<C-j>", "<C-w><C-j>")
nmaps("<C-k>", "<C-w><C-k>")
nmaps("<C-l>", "<C-w><C-l>")

-- Just aliasing this as C-p since it was available. Supress any non-pending currently showing notifications.
nmaps("<C-p>", '<cmd> lua require("notify").dismiss()<CR>')

-- changing window widths
nmaps("]]", "<cmd> lua IncWidth()<CR>")
nmaps("[[", "<cmd> lua DecWidth()<CR>")
nmaps("}}", "<cmd> lua IncHeight()<CR>")
nmaps("{{", "<cmd> lua DecHeight()<CR>")

-- debugging, 'd' for debug
nmapl("dc", "<cmd> lua require'dap'.continue()<CR>")
nmapl("db", "<cmd> lua require'dap'.toggle_breakpoint()<CR>")
nmapl("dt", "<cmd> lua require'dap-gc'.debug_test()<CR>")

--

-- do a search/replace of the current highlighted word
vmap("r", "y:%s/<C-r>0//gI<left><left><left>")

-- go to the previous file
nmapl(",", "<C-^>")

-- view highlight groups
nmapsl("ht", "<cmd>sc $VIMRUNTIME/syntax/hitest.vim<CR>")

-- shortcut to toggle between luasnip choices
vim.keymap.set("s", "<S-Tab>", function()
	if require("luasnip").choice_active() then
		print("in choice")
		return "<Plug>luasnip-next-choice"
	else
		print("NOT in choice")
		return "<S-Tab>"
	end
end, { expr = true })
