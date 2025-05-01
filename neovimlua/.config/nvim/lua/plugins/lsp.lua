local on_attach_ts = function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    command = "EslintFixAll",
  })
end

return {
  "neovim/nvim-lspconfig",
  -- other settings removed for brevity
  event = "BufReadPre",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.eslint.setup({
      on_attach = on_attach_ts,
    })
    lspconfig.gopls.setup{}
    lspconfig.lua_ls.setup{
     settings = {
       Lua = {
         runtime = {
           version = 'LuaJIT', -- Neovim uses LuaJIT
           path = vim.split(package.path, ';'),
         },
         diagnostics = {
           globals = { 'vim' }, -- Recognize the `vim` global
         },
         workspace = {
           library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
           checkThirdParty = false,
         },
         telemetry = {
           enable = false,
         },
       },
     },
   }
    --lspconfig.ts_ls.setup{
    --  --on_attach = on_attach,
    --  root_dir = lspconfig.util.root_pattern("package.json"),
    --  single_file_support = false
    --}
    lspconfig.denols.setup{
      init_options = {
         config = './deno.jsonc',
         lint = true,
       },
    }
    lspconfig.vuels.setup{}
    lspconfig.svelte.setup{}
  end,
}

