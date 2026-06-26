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

nmap("<C-c>", ":cclo<CR>")

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

nmapsl("rc", ":tabedit /.dotfile/neovimlua/.config/nvim/init.lua<CR>")

nmapsl("bc", 'let @+ = expand("%")<CR>')
nmapsl("u !", "bcopy < uuidgen<CR>")
-- resizing.. allow range one day

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
-- Some of these are the same as trouble, so they're commented out
-- nmap("gf", "<cmd>lua vim.lsp.buf.format({ async = false })<CR>")
nmaps("rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
nmaps("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nmaps("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
--nmaps("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>") -- no idea why but everyone does `K`
nmap("f", "<cmd>lua vim.diagnostic.open_float()<CR>") -- F for float
nmap("dn", "<cmd>lua vim.diagnostic.goto_prev()<CR>") -- dn: diag next
nmap("dp", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- dp: diag prev

-- Trouble diagnostics (commented out, set in the plugin)
-- nmaps("tq", "<cmd>Trouble qflist toggle<CR>")
-- nmaps("tr", "<cmd>TroubleToggle lsp_references toggle<CR>")
-- nmaps("tt", "<cmd>Trouble diagnostics toggle<CR>")
-- nmaps("ta", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- apply a quickfix for neovim (Code Action)

-- Why the hell was C-w ever a thing?
-- commented out to be in the config for tmux-navigation
-- nmaps("<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>")
-- nmaps("<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>")
-- nmaps("<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>")
-- nmaps("<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>")
-- nmaps("<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>")
-- nmaps("<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>")

-- Just aliasing this as C-p since it was available. Supress any non-pending currently showing notifications.
-- nmaps("<C-p>", '<cmd> lua require("notify").dismiss()<CR>')

-- changing window widths
nmaps("]]", "<cmd> lua IncWidth()<CR>")
nmaps("[[", "<cmd> lua DecWidth()<CR>")
nmaps("}}", "<cmd> lua IncHeight()<CR>")
nmaps("{{", "<cmd> lua DecHeight()<CR>")

-- debugging, 'd' for debug
-- nmapl("dc", "<cmd> lua require'dap'.continue()<CR>")
-- nmapl("db", "<cmd> lua require'dap'.toggle_breakpoint()<CR>")
-- nmapl("dt", "<cmd> lua require'dap-gc'.debug_test()<CR>")

--

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
  vim.api.nvim_feedkeys('t', 'n', true)
  local line = vim.fn.getline('.')

  if line:find('//') then
    return
  end

  local text_before_cursor = line:sub(vim.fn.col('.') - 4, vim.fn.col('.') -1)
  if text_before_cursor ~= 'awai' then
    return
  end

  local current_node = vim.treesitter.get_node()
  local nodes = {}

  -- set to true to traverse up the tree, false to not traverse and only change one.
  local traverse = false
  find_node_ancestor({
    'function_declaration',
    'function_expression',
    'arrow_function',
  }, nodes, traverse, current_node)

  for _, node in ipairs(nodes) do
    local row, col = node:start()
  
    local function_node_text = vim.treesitter.get_node_text(node, 0)
  
    if vim.startswith(function_node_text, 'async') then
      return
    end
  
    vim.api.nvim_buf_set_text(0, row, col, row, col, {'async '})
  end

end

vim.keymap.set('i', 't', add_async, { buffer = true })

nmapl('rr', ':so ~/.config/nvim/init.lua<CR>')

-- Extract types from a TypeScript assignability error
local function extract_ts_types(msg)
  local arg = msg:match("Argument of type%s+['\"]?([^'\"]+)['\"]?%s+is not assignable")
  local param = msg:match("parameter of type%s+['\"]?([^'\"]+)['\"]?")
  return arg, param
end

-- Get explanation lines like "Type X is not assignable to type Y."
local function extract_ts_explanations(msg)
  local explanations = {}
  local start = msg:find("Types of parameters") or msg:find("Type '")
  if start then
    local trailing = msg:sub(start)
    for line in trailing:gmatch("[^%.]+%.?") do
      local trimmed = vim.trim(line)
      if trimmed ~= "" then
        table.insert(explanations, "- " .. trimmed)
      end
    end
  end
  return explanations
end

-- Format a TypeScript "Argument of type" diagnostic as Markdown
local function format_ts_diagnostic(diag)
  local msg = diag.message:gsub("\r", ""):gsub("\n", " ")
  local arg, param = extract_ts_types(msg)
  local content = { "# ❗ Argument Mismatch (TypeScript)" }

  if arg and param then
    table.insert(content, "## Got")
    table.insert(content, "```ts\n" .. arg .. "\n```")
    table.insert(content, "## Wanted")
    table.insert(content, "```ts\n" .. param .. "\n```")
  else
    table.insert(content, "```ts\n" .. msg .. "\n```")
  end

  vim.list_extend(content, extract_ts_explanations(msg))
  return content
end

-- Format generic diagnostics as Markdown
local function format_generic_diagnostics(diagnostics)
  local content = { "# ❗ Diagnostics" }

  for i, d in ipairs(diagnostics) do
    local msg = d.message:gsub("\r", ""):gsub("\n", " ")
    table.insert(content, string.format("**%d. %s**", i, vim.trim(msg)))
    if d.source then table.insert(content, "`Source: " .. d.source .. "`") end
    if d.code then table.insert(content, "`Code: " .. tostring(d.code) .. "`") end
    table.insert(content, "")
  end

  return content
end

local function format_ts_type_mismatch(diag)
  local msg = diag.message:gsub("\r", ""):gsub("\n", " ")

  -- Match actual (got) and expected type
  local got = msg:match("Type%s+'([^']+)'%s+is not assignable")
  local expected = msg:match("to type%s+'([^']+)'")

  if not got or not expected then
    return { "# ❗ Type Mismatch", "```ts\n" .. diag.message .. "\n```" }
  end

  local title = "# ❗ Type Mismatch"
  if got:find("^%(") and got:find("%)%s*=>") then
    title = "# ❗ Function Type Mismatch"
  elseif got:find("^{") then
    title = "# ❗ Object Shape Mismatch"
  end

  local content = {
    title,
    "## Got",
    "```ts\n" .. got .. "\n```",
    "## Expected",
    "```ts\n" .. expected .. "\n```"
  }

  -- Add follow-up assignability notes
  for line in msg:gmatch("[^%.]+%.") do
    local trimmed = vim.trim(line)
    if trimmed:find("is not assignable to type") or trimmed:find("missing the following properties") then
      table.insert(content, "- " .. trimmed)
    end
  end

  return content
end

local function format_ts_argument_mismatch(diag)
  local msg = diag.message:gsub("\r", "") -- keep newlines for pretty-printing
  local got = msg:match("Argument of type%s+(.-)%s+is not assignable")
  local expected = msg:match("to parameter of type%s+(.-)[%.,]")

  local content = { "# ❗ Argument Mismatch (TypeScript)" }

  if got and expected then
    table.insert(content, "## Got")
    table.insert(content, "```ts\n" .. vim.trim(got) .. "\n```")
    table.insert(content, "## Expected")
    table.insert(content, "```ts\n" .. vim.trim(expected) .. "\n```")
  else
    table.insert(content, "```ts\n" .. diag.message .. "\n```")
    return content
  end

  -- Extract any explanatory lines after the type mismatch
  local explanation_start = msg:find("Property ") or msg:find("but required in type") or msg:find("missing in type")
  if explanation_start then
    local trailing = msg:sub(explanation_start)
    for line in trailing:gmatch("[^\n]+") do
      local trimmed = vim.trim(line)
      if trimmed ~= "" then
        table.insert(content, "- " .. trimmed)
      end
    end
  end

  return content
end
-- Main function: determines how to format diagnostics
function ShowDiagnosticMarkdown()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

  if #diagnostics == 0 then return end

  local content = nil

  for _, diag in ipairs(diagnostics) do
    if diag.message:find("Argument of type") then
      content = format_ts_diagnostic(diag)
      break
    end
    if diag.message:find("is not assignable to type") then
      content = format_ts_type_mismatch(diag)
      break
    end
  end

  if not content then
    content = format_generic_diagnostics(diagnostics)
  end

  local opts = {
    border = "rounded",
    max_width = 80,
    focusable = false,
  }

  vim.lsp.util.open_floating_preview(content, "markdown", opts)
end

nmap("F", ":lua ShowDiagnosticMarkdown()<CR>")

-- Example keybinding to show it
