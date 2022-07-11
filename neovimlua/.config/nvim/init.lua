-- helpful resource: https://icyphox.sh/blog/nvim-lua/
require('settings')
require('plugins')
require('plugins_settings')
require('maps')
require('augroups')
require('functions')
require('lsp')

local cmd = vim.cmd

-- This has to be set after settings and plugins I guess
vim.g.catppuccin_flavour = "frappe"
cmd("colorscheme catppuccin")

-- gray
cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
-- blue
cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
-- light blue
cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
cmd [[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]]
-- pink
cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
cmd [[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]]
-- front
cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
cmd [[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
cmd [[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]

-- override the default notify with popups in the corner
vim.notify = require("notify")
