-- helpful resource: https://icyphox.sh/blog/nvim-lua/
require("settings")
require("plugins")
require("plugins_settings")
require("maps")
require("augroups")
require("autosave")
require("functions")
require("lsp")

-- override the default notify with popups in the corner
-- I think it might be annoying.
-- vim.notify = require("notify")
