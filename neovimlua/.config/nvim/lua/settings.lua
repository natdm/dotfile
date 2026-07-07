local o = vim.o
local wo = vim.wo
local g = vim.g

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.spelllang = "en_us"
vim.opt.spell = true

g.mapleader = " "
o.timeoutlen = 500
o.mouse = ""
o.visualbell = true
o.number = true
o.updatetime = 100
o.hidden = true
o.termguicolors = true
o.cmdheight = 1
o.encoding = "UTF-8"
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

wo.cursorline = true
wo.signcolumn = "yes"

vim.cmd("set clipboard+=unnamedplus")
