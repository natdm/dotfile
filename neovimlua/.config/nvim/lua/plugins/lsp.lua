return {
  "neovim/nvim-lspconfig",
  -- other settings removed for brevity
  event = "BufReadPre",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup{}
    lspconfig.vuels.setup{}
    lspconfig.ts_ls.setup{}
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })
  end,
}

