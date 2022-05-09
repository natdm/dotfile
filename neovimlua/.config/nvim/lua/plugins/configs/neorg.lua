require('neorg').setup {
	ensure_installed = { "norg" },
	    highlight = { -- Be sure to enable highlights if you haven't!
        enable = true,
    },
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        }
    }
}
