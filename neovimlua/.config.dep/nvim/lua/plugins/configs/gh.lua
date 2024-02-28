require('litee.lib').setup({
    tree = {
        icon_set = "codicons"
    },
    panel = {
        orientation = "right",
        panel_size  = 30
    },
    term = {
        position = "bottom",
        term_size = 15,
    }
})
require('litee.gh').setup({
    icon_set = "codicons",
    map_resize_keys = true
})
-- vim.cmd("FzfLua register_ui_select")
