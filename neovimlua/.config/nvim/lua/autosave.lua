-- echo nvim_get_current_buf()
-- source ~/.dotfile/neovimlua/.config/nvim/lua/autosave.lua

local print_output = function(output_bufnr)
	return function(_, data)
		if data and data[1] ~= "" then
			vim.api.nvim_buf_set_lines(output_bufnr, -0, 0, false, data)
		end
	end
end
local attach_to_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
		pattern = pattern,
		callback = function()
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {})
			vim.fn.jobstart(command, {
				stdout_buffer = true,
				on_stdout = print_output(output_bufnr),
				on_stderr = print_output(output_bufnr),
			})
		end,
	})
end

vim.api.nvim_create_user_command("AutoRunStop", function()
	vim.api.nvim_del_augroup_by_name("AutoRun")
end, {})

vim.api.nvim_create_user_command("AutoRunStart", function()
	print("Autorunning..")
	local bufnr = vim.fn.input("Buffer: ")
	local pattern = vim.fn.input("Pattern: ")
	local command = vim.split(vim.fn.input("Command: "), " ")
	attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})
