local keymap = require("utils.keymap")

local g = vim.g
local cmd = vim.cmd

local nmap = keymap.nmap
local nmapsl = keymap.nmapsl
local nmaps = keymap.nmaps
local nmapl = keymap.nmapl
local imap = keymap.imap
local vmap = keymap.vmap

-- the next two lines are equivalent to these two:
-- nnoremap <SPACE> <Nop>
-- let mapleader=" "
nmap("<Space>", "")
g.mapleader = " "

nmap("<C-c>", ":cclo<CR>")

nmapsl("fx", ":set hlsearch!<CR>")

-- keep search results in the center of the screen
-- n(ext)zz(center cursor)zv(open folds if any)
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
-- [c and ]c go to next diff sections, with zz to center
nmap("]c", "]czz")
nmap("[c", "[czz")

-- a better way to collapse lines
nmap("J", "mzJ`z")

-- moving texts around, and also obey indentation rules
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

nmapsl("rc", ":tabedit /.dotfile/neovimlua/.config/nvim/init.lua<CR>")

nmapsl("bc", 'let @+ = expand("%")<CR>')
nmapsl("u !", "bcopy < uuidgen<CR>")

nmapsl("tn", ":tabnew<CR>")
nmapsl("tx", ":tabclose<CR>")
nmapsl("ts", ":tab split<CR> ")

if not vim.g.vscode then
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
end

nmapsl("bf", ":BufOnly<CR> ")

-- Paste and don't yank the underlying buffer, overriding default `p`
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

-- changing window widths
nmaps("]]", "<cmd> lua IncWidth()<CR>")
nmaps("[[", "<cmd> lua DecWidth()<CR>")
nmaps("}}", "<cmd> lua IncHeight()<CR>")
nmaps("{{", "<cmd> lua DecHeight()<CR>")

-- do a search/replace of the current highlighted word
vmap("R", "y:%s/<C-r>0//gI<left><left><left>")

nmap("<C-s>", ":ToggleSplitSize<CR>")

local function find_node_ancestor(types, nodes, traverse, node)
  if not node then
    return
  end

  if vim.tbl_contains(types, node:type()) then
    table.insert(nodes, node)
  end

  if not traverse and #nodes > 0 then
    return
  end

  find_node_ancestor(types, nodes, traverse, node:parent())
end

local function add_async()
  vim.api.nvim_feedkeys("t", "n", true)
  local line = vim.fn.getline(".")

  if line:find("//") then
    return
  end

  local text_before_cursor = line:sub(vim.fn.col(".") - 4, vim.fn.col(".") - 1)
  if text_before_cursor ~= "awai" then
    return
  end

  local current_node = vim.treesitter.get_node()
  local nodes = {}

  -- set to true to traverse up the tree, false to not traverse and only change one.
  local traverse = false
  find_node_ancestor({
    "function_declaration",
    "function_expression",
    "arrow_function",
  }, nodes, traverse, current_node)

  for _, node in ipairs(nodes) do
    local row, col = node:start()

    local function_node_text = vim.treesitter.get_node_text(node, 0)

    if vim.startswith(function_node_text, "async") then
      return
    end

    vim.api.nvim_buf_set_text(0, row, col, row, col, { "async " })
  end
end

vim.keymap.set("i", "t", add_async, { buffer = true })

nmapl("rr", ":so ~/.config/nvim/init.lua<CR>")

nmap("F", ":lua require('utils.diagnostics').show_diagnostic_markdown()<CR>")
