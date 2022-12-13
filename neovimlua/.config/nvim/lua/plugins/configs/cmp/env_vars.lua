local source = {}

source.new = function()
	return setmetatable({ cache = {} }, { __index = source })
end

source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		local items = {}
		local label = "$"
		if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
						label = ""
		end
		for k, _ in pairs(vim.fn.environ()) do
			table.insert(items, {
				value = k,
				label = label .. k,
			})
		end
		callback({ items = items, isIncomplete = false })
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

source.get_trigger_characters = function()
	return { "$", "process.env.", "process.env[']", "os.Getenv("}
end

local available_file_types = {
				["sh"] = true,
				["bash"] = true,
				["zsh"] = true,
				["javascript"] = true,
				["typescript"] = true,
}

source.is_available = function()
	return available_file_types[vim.bo.filetype]
end

require("cmp").register_source("env_vars", source.new())
