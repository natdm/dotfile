function SetColorscheme(color)
	color = color or "everforest"
	vim.opt.background = "dark"
	vim.cmd.colorscheme(color)
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- the below line makes float windows also transparent, but it's hard to distinguish
	-- Consider setting a float border, though I tried that and it wasn't super pretty
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

SetColorscheme()

function _G.BGOpacity()
	print(vim.inspect(vim.api.nvim_get_hl_by_name("Normal", true)))
	print(vim.inspect(vim.api.nvim_get_hl_by_name("EndOfBuffer", true)))
end
