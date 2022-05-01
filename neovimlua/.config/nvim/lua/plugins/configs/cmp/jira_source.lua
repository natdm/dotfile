local Job = require("plenary.job")

local source = {}

source.new = function()
    local self = setmetatable({cache = {}}, {__index = source})

    return self
end

source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.env.JIRA_QUERY then
        vim.notify "env JIRA_QUERY not set"
        return
    end

    if not self.cache[bufnr] then
        Job:new({
            "jira",
            "ls",
            "-q",
            vim.env.JIRA_QUERY,
            "-l",
            vim.env.JIRA_QUERY_LIMIT or "100",

            on_exit = function(job)
                local result = job:result()
                local items = {}
                for _, jira_item in ipairs(result) do
                    local _, _, locator, desc = string.find(jira_item, "(%a+-%d+):%s+(.+)")
                    table.insert(items, {
                        label = locator,
                        documentation = { --
                            kind = "markdown",
                            value = string.format("# %s\n\n%s", locator, desc)
                        }
                    })
                end

                callback {items = items, isIncomplete = false}
                self.cache[bufnr] = items
            end
        }):start()
    else
        callback {items = self.cache[bufnr], isIncomplete = false}
    end
end

-- source.get_trigger_characters = function()
--     return {"#"}
-- end

source.is_available = function()
    local ft = vim.bo.filetype
    return ft == "vimwiki" or ft == "gitcommit" or ft == "markdown"
end

require("cmp").register_source("jira_issues", source.new())
