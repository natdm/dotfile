return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  keys = {
    { "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover documentation" },
    { "f", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open diagnostic float" },
    { "dn", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous diagnostic" },
    { "dp", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
  },
  config = function()
    vim.lsp.config.eslint = {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    }

    vim.lsp.config.gopls = {}

    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim" },
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

    vim.lsp.config.ts_ls = {
      root_markers = { "package.json" },
      single_file_support = false,
    }

    vim.lsp.config.vuels = {}

    vim.lsp.config.svelte = {}

    vim.lsp.enable({ "eslint", "gopls", "lua_ls", "ts_ls", "vuels", "svelte" })
  end,
}
