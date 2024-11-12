return {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function()
      require('CopilotChat').setup({})
    end,
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
    {
      "?",
      function()
        local input = vim.fn.input("Whatcha thinkin' about: ")
        if input ~= "" then
          require("CopilotChat").ask(input, {
            selection = require("CopilotChat.select").visual 
          })
        end
      end,
      desc = "CopilotChat - Quick chat on visal selection",
      mode = "v",
    },
    {
      "<leader>ccq",
      function()
        local input = vim.fn.input("Whatcha thinkin' about: ")
        if input ~= "" then
          require("CopilotChat").ask(input, {
            selection = require("CopilotChat.select").buffer 
          })
        end
      end,
      desc = "CopilotChat - Quick chat",
    },
    {
      "<leader>cch",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
      end,
      desc = "CopilotChat - Help actions",
    },
    -- Show prompts actions with fzf-lua
    {
      "<leader>ccp",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat - Prompt actions",
    },
  },
}
