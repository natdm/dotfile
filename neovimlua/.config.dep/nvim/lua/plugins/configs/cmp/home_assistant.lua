local Job = require("plenary.job")

local source = {}

source.new = function()
	local self = setmetatable({ cache = {} }, { __index = source })

	return self
end

source.complete = function(self, _, callback)
	local bufnr = vim.api.nvim_get_current_buf()
	if not vim.env.HA_URL then
		vim.notify("env HA_URL not set")
		return
	end

	if not self.cache[bufnr] then
		Job
			:new({
				"curl",
				"-X",
				"GET",
				vim.env.HA_URL .. "/api/states",
				"-H",
				"Authorization: Bearer " .. vim.env.HA_AUTH,
				"-H",
				"Content-Type: application/json",
				on_exit = function(job)
					local result = job:result()
					-- local items = {}
					--
					-- callback({ items = items, isIncomplete = false })
					-- self.cache[bufnr] = items

					print(vim.inspect(vim.fn.json_decode(result)))
				end,
			})
			:start()
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

source.get_trigger_characters = function()
	return { "state." }
end

source.is_available = function()
	return true
end

require("cmp").register_source("home_assistant", source.new())
