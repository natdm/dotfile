local bg_value
local opaque = false

-- Opacity will toggle between the colorschemes bg and opacity.
function _G.Opacity()
	if opaque then
		opaque = false
		vim.api.nvim_set_hl(0, "Normal", { bg = "#" .. string.format("%x", bg_value.background) })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#" .. string.format("%x", bg_value.background) })
	else
		opaque = true
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- the below line makes float windows also transparent, but it's hard to distinguish
		-- Consider setting a float border, though I tried that and it wasn't super pretty
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	end
end

function SetColorscheme(color)
	color = color or "everforest"
	vim.opt.background = "dark"
	vim.cmd.colorscheme(color)
	bg_value = vim.api.nvim_get_hl_by_name("Normal", true)
end

SetColorscheme()

function _G.BG()
	print(vim.inspect(bg_value))
end
