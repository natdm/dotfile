local diagnostics = require("utils.diagnostics")

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
    format = diagnostics.format_ts_type_errors
  },
})

require("commands")
require("settings")
require("plugins")
require("maps")
require("abbreviations")
