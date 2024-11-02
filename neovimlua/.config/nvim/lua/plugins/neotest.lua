return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- being lazy, below is just for jest
    "nvim-neotest/neotest-jest"
  },
  config = function ()
    require('neotest').setup({
      discovery = {
	    	enabled = false,
	    },
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm run test:unit --",
          jest_test_discovery = false,
          jestConfigFile = function(file)
            if string.find(file, "/packages/") then
              local config = string.match(file, "(.-/[^/]+/)test") .. "jest.config.ts"
              return config
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          env = { CI = true },
          cwd = function(file)
            if string.find(file, "/packages") then
              local dir = string.match(file, "(.-/[^/]+/)test")
              return dir
            end
            return vim.fn.getcwd()
          end
        }),
      }
    })
  end,
}
