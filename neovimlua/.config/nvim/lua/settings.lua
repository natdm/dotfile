local o = vim.o -- global-setting (but be careful because there is a vim.g which is global)
local wo = vim.wo -- window-only
local bo = vim.bo -- buffer-only
vim.cmd("filetype plugin on")

-- Global settings
o.timeoutlen = 500
o.visualbell = true
o.number = true
o.updatetime = 100
o.hidden = true
-- g.shortmess +=c
o.termguicolors = true
o.cmdheight = 1
o.encoding = "UTF-8"
-- set foldcolumn=3
o.inccommand = "nosplit"
o.undofile = true
o.smartcase = true
o.ignorecase = true
o.splitright = true
o.splitbelow = true
o.wrap = true
o.linebreak = true
o.lazyredraw = true
o.hlsearch = true
o.showmode = false
o.scrolloff = 5
o.sidescrolloff = 5
o.swapfile = false
o.smarttab = false

-- Window setttings
wo.cursorline = true
wo.signcolumn = "yes" -- needed for Gitsigns
-- buffer settings
-- On pressing tab, insert 2 spaces
bo.expandtab = true
-- show existing tab with 2 spaces width
bo.tabstop = 2
bo.softtabstop = 0
-- when indenting with '>', use 2 spaces width. For some reason this doesn't work in vimwiki.
bo.shiftwidth = 2
