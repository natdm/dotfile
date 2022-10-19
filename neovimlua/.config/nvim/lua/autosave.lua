local bufnr = 31

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("Foo", { clear = true }),
	pattern = "main.go",
	callback = function()
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
		vim.fn.jobstart({ "go", "run", "main.go" }, {
			stdout_buffer = true,
			on_stdout = function (_, data)
				if data and data[1] ~= "" then
					vim.api.nvim_buf_set_lines(bufnr, -0, 0, false, data)
				end
			end,
			on_stderr = function (_, data)
				if data and data[1] ~= "" then
					vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, data)
				end
			end
		})
	end,
})
