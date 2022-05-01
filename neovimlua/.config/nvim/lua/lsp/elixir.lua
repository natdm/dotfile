local elixir_ls_path = vim.fn.expand('~/.elixir-ls/release/language_server.sh')

require('lspconfig').elixirls.setup {cmd = {elixir_ls_path}, settings = {elixirLS = {dialyzerEnabled = true, mixEnv = 'test'}}}
