local Job = require("plenary.job")

local source = {}

source.new = function()
	local self = setmetatable({ cache = {} }, { __index = source })

	return self
end

source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		Job
			:new({
				"history",
				"50",
				on_exit = function(job)
					local result = job:result()
					local items = {}

					print(vim.inspect(result))
					for _, list in ipairs(result) do
						for s in list:gmatch("[^\r\n]+") do
							table.insert(items, {
								label = s,
								documentation = { --
									kind = "text",
									value = s,
								},
							})
						end
					end

					callback({ items = items, isIncomplete = false })
					self.cache[bufnr] = items
				end,
			})
			:start()
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

-- source.get_trigger_characters = function()
-- 	return { "@" }
-- end

local available_file_types = {
	["sh"] = true,
	["bash"] = true,
	["zsh"] = true,
}

source.is_available = function()
	return available_file_types[vim.bo.filetype]
end

require("cmp").register_source("history", source.new())
