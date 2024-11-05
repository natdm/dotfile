local null_ls = require("null-ls")

null_ls.setup({
  debug = true,
  sources = {
    -- ESLint diagnostics and formatting, using eslint_d for speed
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
      end,
    }),
    null_ls.builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
      end,
    }),
  },
  on_attach = function(client, bufnr)
    -- Set up auto-formatting on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

