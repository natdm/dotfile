local Job = require("plenary.job")

local source = {}

source.new = function()
    local self = setmetatable({cache = {}}, {__index = source})

    return self
end

source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.env.GH_ORG_MEMBERS_URL then
        vim.notify "env GH_ORG_MEMBERS_URL not set"
        return
    end

    if not self.cache[bufnr] then
        Job:new({
            "gh",
            "api",
            vim.env.GH_ORG_MEMBERS_URL,
	    "-q",
	    ".[] | [.login, .type, .site_admin]",

            on_exit = function(job)
                local result = job:result()
                local items = {}

                for _, list in ipairs(result) do
			for s in list:gmatch("[^\r\n]+") do
				local _, _, username, typ, admin = string.find(s, '%["([^"]*)","(%a+)",(%a+)%]') -- ["username","User",false]
				    table.insert(items, {
					label = "@"..username,
					documentation = { --
					    kind = "text",
					    value = string.format("@%s\n\nType: %s\nAdmin: \n%s", username, typ, admin)
					}
				    })
			end
                end

                callback {items = items, isIncomplete = false}
                self.cache[bufnr] = items
            end
        }):start()
    else
        callback {items = self.cache[bufnr], isIncomplete = false}
    end
end

source.get_trigger_characters = function()
    return {"@"}
end

source.is_available = function()
    local ft = vim.bo.filetype
    return ft == "vimwiki" or ft == "gitcommit" or ft == "markdown"
end

require("cmp").register_source("gh_users", source.new())
