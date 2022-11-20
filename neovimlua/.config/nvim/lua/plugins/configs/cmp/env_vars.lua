local source = {}

source.new = function()
	return setmetatable({ cache = {} }, { __index = source })
end

source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		local items = {}
		for k, _ in pairs(vim.fn.environ()) do
			table.insert(items, {
				value = k,
				label = "$" .. k,
			})
		end
		callback({ items = items, isIncomplete = false })
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

source.get_trigger_characters = function()
	return { "$" }
end

source.is_available = function()
	local ft = vim.bo.filetype
	return ft == "sh" or ft == "bash" or ft == "zsh"
end

require("cmp").register_source("env_vars", source.new())
