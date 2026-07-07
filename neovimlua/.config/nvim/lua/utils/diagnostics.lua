local M = {}

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
  local content = { "# Argument Mismatch (TypeScript)" }

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
  local content = { "# Diagnostics" }

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

  local got = msg:match("Type%s+'([^']+)'%s+is not assignable")
  local expected = msg:match("to type%s+'([^']+)'")

  if not got or not expected then
    return { "# Type Mismatch", "```ts\n" .. diag.message .. "\n```" }
  end

  local title = "# Type Mismatch"
  if got:find("^%(") and got:find("%)%s*=>") then
    title = "# Function Type Mismatch"
  elseif got:find("^{") then
    title = "# Object Shape Mismatch"
  end

  local content = {
    title,
    "## Got",
    "```ts\n" .. got .. "\n```",
    "## Expected",
    "```ts\n" .. expected .. "\n```"
  }

  for line in msg:gmatch("[^%.]+%.") do
    local trimmed = vim.trim(line)
    if trimmed:find("is not assignable to type") or trimmed:find("missing the following properties") then
      table.insert(content, "- " .. trimmed)
    end
  end

  return content
end

-- Format TypeScript type errors for diagnostic float
function M.format_ts_type_errors(diagnostic)
  local msg = diagnostic.message
  if not msg:find("Argument of type") then
    return msg
  end

  msg = msg:gsub("\r", ""):gsub("\n", " ")

  local arg_type = msg:match("Argument of type%s+['\"]?([^'\"]+)['\"]?%s+is not assignable")
  local param_type = msg:match("parameter of type%s+['\"]?([^'\"]+)['\"]?")

  local formatted = { "Argument mismatch:" }

  if arg_type and param_type then
    table.insert(formatted, arg_type)
    table.insert(formatted, param_type)
  else
    table.insert(formatted, msg)
  end

  local explanations = {}
  local start = msg:find("Types of parameters") or msg:find("Type '")
  if start then
    local trailing = msg:sub(start)
    for line in trailing:gmatch("[^%.]+%.?") do
      local trimmed = vim.trim(line)
      if trimmed ~= "" then
        table.insert(explanations, trimmed)
      end
    end
  end

  for _, line in ipairs(explanations) do
    table.insert(formatted, "- " .. line)
  end

  local code = msg:match("%[(%d+)%]") or diagnostic.code
  if code then
    table.insert(formatted, string.format("[%s]", code))
  end

  return table.concat(formatted, "\n")
end

-- Show diagnostic as markdown in floating window
function M.show_diagnostic_markdown()
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

return M
