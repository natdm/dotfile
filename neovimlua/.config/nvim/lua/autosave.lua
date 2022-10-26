-- echo nvim_get_current_buf()

local print_output = function(output_bufnr)
	return function(_, data)
		if data and data[1] ~= "" then
			vim.api.nvim_buf_set_lines(output_bufnr, 0, 0, false, data)
		end
	end
end
local attach_to_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
		pattern = pattern,
		callback = function()
			-- clear the buffer
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
	if bufnr == "" then
		bufnr = vim.api.nvim_get_current_buf()
	else
		bufnr = tonumber(bufnr)
	end
	local pattern = vim.fn.input("Pattern: ")
	local command = vim.fn.input("Command: ")
	-- this takes 'coreutils', installed with brew, for it to work
	command = "timeout --signal=SIGINT 10 " .. command
	print("On save, running: " .. command)
	attach_to_buffer(bufnr, pattern, vim.split(command, " "))
end, {})
