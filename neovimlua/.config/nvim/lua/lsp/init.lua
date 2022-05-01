require('lsp.lua')
require('lsp.elixir')
require('lsp.efm')
require('lsp.go')
require('lsp.ts')

local lspconfig = require('lspconfig')

lspconfig.pyright.setup({})
lspconfig.bashls.setup({})
lspconfig.vimls.setup({})
lspconfig.cmake.setup({})
