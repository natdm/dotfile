local g = vim.g
-- This entire file is pretty much deprecated and these should be sent to other files for each specific plugin.

g.user_emmet_leader_key = '<C-E>'

g.cursorhold_updatetime = 100

-- markdown stuff
g.markdown_syntax_conceal = 0
g.markdown_minlines = 100

-- this changes the color of alternating indentations for indent_guidelines.
-- It's only activated for a few files, but it's annoying if it's too much.
g.indent_guides_color_change_percent = 4

g.gitgutter_override_sign_column_highlight = 0


g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- vimwiki
g.vimwiki_list = {{path = '~/wiki/', syntax = 'markdown', ext = '.md'}}

require('lualine').setup({options = {theme = "everforest"}})
require('shade').setup({overlay_opacity = 80})

