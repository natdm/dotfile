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
  keys = {
    {
      "<leader>rt", 
			"<cmd>lua require('neotest').run.run()<CR>", 
			desc = "Run test" 
    },
    { 
      "<leader>rF", 
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", 
			desc = "Run test on file" 
    },
    {
      "<leader>rs", 
			"<cmd>lua require('neotest').summary.toggle()<CR>", 
			desc = "Toggle test summary" 
    },
  },
  config = function ()
    require('neotest').setup({
      discovery = {
	    	enabled = false,
	    },
      log_level = vim.log.levels.DEBUG,
      summary = {
        open = "botright vsplit | vertical resize 60",
      },
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm run test:unit --",
          jest_test_discovery = false,
          log_level = vim.log.levels.DEBUG,
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
