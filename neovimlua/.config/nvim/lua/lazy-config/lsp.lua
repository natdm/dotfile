-- ~/.config/nvim/lua/lazy-config/lsp.lua
local lspconfig = require("lspconfig")

-- TypeScript setup with tsserver
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Disable tsserver's formatting as we'll use ESLint
    client.server_capabilities.documentFormattingProvider = false
  end,
})
