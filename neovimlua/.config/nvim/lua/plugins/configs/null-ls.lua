local null_ls = require("null-ls")

require("null-ls").setup({
	-- on_attach = function(client)
		-- NOTE: don't format here, there's formatting in the tsserver that works better. 
	-- end,
	sources = {
		null_ls.builtins.formatting.prettier, -- prettier, eslint, eslint_d, or prettierd
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
		null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
		null_ls.builtins.completion.spell,
	},
})
