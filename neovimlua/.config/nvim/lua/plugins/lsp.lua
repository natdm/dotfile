-- return {
--   "dundalek/lazy-lsp.nvim",
--   dependencies = {
--     "neovim/nvim-lspconfig",
--     {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/nvim-cmp",
--   },
--   config = function()
--     local lsp_zero = require("lsp-zero")
-- 
--     lsp_zero.on_attach(function(client, bufnr)
--       -- see :help lsp-zero-keybindings to learn the available actions
--       lsp_zero.default_keymaps({
--         buffer = bufnr,
--         preserve_mappings = false
--       })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--          buffer = bufnr,
--          command = "EslintFixAll",
--        })
--     end)
-- 
--     require("lazy-lsp").setup {
--         excluded_servers = {"denols", "tailwindcss"},
--         preferred_servers = {
--           typescript = {"tsserver", "eslint"},
--           javascript = {"tsserver", "eslint"},
--         }
--     }
--   end,
-- }

  -- lspconfig.eslint.setup({
  --   --- ...
  --   on_attach = function(client, bufnr)
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       buffer = bufnr,
  --       command = "EslintFixAll",
  --     })
  --   end,
  -- })
return {
  "neovim/nvim-lspconfig",
  -- other settings removed for brevity
  opts = {
    servers = {
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectories = { mode = "auto" },
        },
      },
    },
    setup = {
      eslint = function()
        local function get_client(buf)
          return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
        end

        local formatter = LazyVim.lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })

        -- Use EslintFixAll on Neovim < 0.10.0
        if not pcall(require, "vim.lsp._dynamic") then
          formatter.name = "eslint: EslintFixAll"
          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "eslint" } or {}
          end
          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end
        end

        -- register the formatter with LazyVim
        LazyVim.format.register(formatter)
      end,
    },
  },
}
