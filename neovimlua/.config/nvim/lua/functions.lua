local ts_utils = require("nvim-treesitter.ts_utils")
local utils = require("nvim-treesitter.utils")
local locals = require("nvim-treesitter.locals")
local query = require("nvim-treesitter.query")
local api = vim.api

function _G.put(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	print(table.concat(objects, "\n"))
	return ...
end

-- rename things. It's really broken, but a cool concept
function _G.rename(bufnr)
	bufnr = bufnr or api.nvim_get_current_buf()
	local cursor_node = ts_utils.get_node_at_cursor()
	local expression = cursor_node
	if not expression then
		utils.print_warning("no node..")
		return
	end

	local node_text = ts_utils.get_node_text(expression)[1]
	local new_name = vim.fn.input("New name: ", node_text or "")
	-- Empty name cancels the interaction or ESC
	if not new_name or #new_name < 1 then
		return
	end
	local definition, scope = locals.find_definition(expression, bufnr)
	local nodes_to_rename = {}
	nodes_to_rename[expression:id()] = expression
	nodes_to_rename[definition:id()] = definition

	for _, n in ipairs(locals.find_usages(definition, scope, bufnr)) do
		nodes_to_rename[n:id()] = n
	end

	local edits = {}

	for _, node in pairs(nodes_to_rename) do
		local lsp_range = ts_utils.node_to_lsp_range(node)
		local text_edit = { range = lsp_range, newText = new_name }
		table.insert(edits, text_edit)
	end
	vim.lsp.util.apply_text_edits(edits, bufnr)
end

function P(v)
	print(vim.inspect(v))
	return v
end

function _G.Arities()
	local bufnr = api.nvim_get_current_buf()
	local cursor_node = ts_utils.get_node_at_cursor()
	local txt = P(ts_utils.get_node_text(cursor_node)[1])

	-- TODO: if node isn't a function (how to tell?) then get parent node until it is.
	-- Currently, cursor has to be over function
	local entries = {}
	local matches = query.get_capture_matches(bufnr, "@definition.function", "locals", nil, "elixir")
	for _, n in ipairs(matches) do
		local n_txt = ts_utils.get_node_text(n.node)[1]
		if n_txt == txt then
			local range = ts_utils.node_to_lsp_range(n.node)
			local start_line = range.start.line + 1
			local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]
			table.insert(entries, { bufnr = bufnr, lnum = start_line, col = range.start.character + 1, text = line })
		end
	end
	vim.fn.setqflist(entries, "r")
end

function _G.Query()
	local bufnr = api.nvim_get_current_buf()
	-- available query groups, I guess..
	-- { "query-linter-queries", "highlights", "locals", "captures", "indents", "injections", "folds" }
	local matches = query.get_capture_matches(bufnr, "@definition.function", "locals", nil, "elixir")
	for _, n in ipairs(matches) do
		P(ts_utils.get_node_text(n.node))
	end

	-- P(query.available_query_groups())
end

function _G.RenameWithQuickfix()
	local position_params = vim.lsp.util.make_position_params()
	local current_name = ts_utils.get_node_text(ts_utils.get_node_at_cursor())[1]
	-- prompt for the new name, giving the current name as the default
	local new_name = vim.fn.input("New Name > ", current_name)

	-- set the newname for the lsp server request
	position_params.newName = new_name

	-- override the request to the lsp with a custom response callback
	vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, method, result, ...)
		-- call the default lsp handler
		vim.lsp.handlers["textDocument/rename"](err, method, result, ...)

		-- go through the entities that were changed and add them to a quickfix table
		local entries = {}
		if result.changes then
			for uri, edits in pairs(result.changes) do
				local bufnr = vim.uri_to_bufnr(uri)

				for _, edit in ipairs(edits) do
					local start_line = edit.range.start.line + 1
					local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

					table.insert(
						entries,
						{ bufnr = bufnr, lnum = start_line, col = edit.range.start.character + 1, text = line }
					)
				end
			end
		end

		-- set the quickfix entries here
		vim.fn.setqflist(entries, "r")
	end)
end

function _G.Diagnostics()
	local method = "textDocument/publishDiagnostics"
	local default_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
		default_handler(err, method, result, client_id, bufnr, config)
		local diagnostics = vim.lsp.diagnostic.get_all()
		local qflist = {}
		for bufnr, diagnostic in pairs(diagnostics) do
			for _, d in ipairs(diagnostic) do
				d.bufnr = bufnr
				d.lnum = d.range.start.line + 1
				d.col = d.range.start.character + 1
				d.text = d.message
				table.insert(qflist, d)
			end
		end
		vim.lsp.util.set_qflist(qflist)
	end
end

function AlterWinWidth(n)
	api.nvim_win_set_width(0, api.nvim_win_get_width(0) + n)
end

function AlterWinHeight(n)
	api.nvim_win_set_height(0, api.nvim_win_get_height(0) + n)
end

function _G.IncWidth()
	AlterWinWidth(5)
end

function _G.DecWidth()
	AlterWinWidth(-5)
end

function _G.IncHeight()
	AlterWinHeight(5)
end

function _G.DecHeight()
	AlterWinHeight(-5)
end

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Run tests for a file in a split.
-- This doesn't run incrementally since that's probably done better in tmux.
function _G.ExTest()
	local file = vim.fn.expand("%:p")
	if not string.find(file, ".ex") then
		return
	end

	file = string.gsub(file, "/lib/", "/test/")
	file = string.gsub(file, ".ex", "_test.exs")

	if file_exists(file) then
		vim.cmd("vsplit | terminal")
		local command = ':call jobsend(b:terminal_job_id, "mix test ' .. file .. '\\n")'
		vim.cmd(command)
	else
		print("Does not exist: " .. file)
	end
end

function _G.TestFileRace()
	require("neotest").run.run({ path = vim.fn.expand("%"), extra_args = { "-race" } })
end

function _G.TestAllRace()
	require("neotest").run.run({ extra_args = { "-race" } })
end

function _G.TestSummary()
	require("neotest").summary.toggle()
end
