return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    -- ESLint with auto-fix on save
    vim.lsp.config.eslint = {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    }

    -- Go
    vim.lsp.config.gopls = {}

    -- Lua
    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- TypeScript
    vim.lsp.config.ts_ls = {
      root_markers = { "package.json" },
      single_file_support = false,
    }

    -- Vue
    vim.lsp.config.vuels = {}

    -- Svelte
    vim.lsp.config.svelte = {}

    -- Enable all configured servers
    vim.lsp.enable({ 'eslint', 'gopls', 'lua_ls', 'ts_ls', 'vuels', 'svelte' })
  end,
}

