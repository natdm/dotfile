local source = {}

source.new = function()
	local self = setmetatable({ cache = {} }, { __index = source })

	return self
end

source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		local env_vars = vim.fn.environ()
		local items = {}
		for k, _ in pairs(env_vars) do
			table.insert(items, {
				label = k,
				value = "$" .. k,
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
