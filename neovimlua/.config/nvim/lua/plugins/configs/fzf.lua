local g = vim.g

local setenv = vim.fn.setenv
local command = vim.api.nvim_command
-- FZF
-- This is to toggle incremental highlighting from searches done with /
-- THERE ARE MORE SETTINGS IN COC
-- Enable per-command history.
-- CTRL-N and CTRL-P will be automatically bound to next-history and
-- previous-history instead of down and up. If you don't like the change,
-- explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
g.fzf_history_dir = '~/.local/share/fzf-history'
g.fzf_preview_window = {'up:40%', 'ctrl-/'}
g.fzf_tags_command = 'ctags -R'
-- Border color
local fzf_layout = {}
fzf_layout['up'] = '~90%'
local fzf_layout_window = {}
fzf_layout_window['width'] = 0.8
fzf_layout_window['height'] = 0.8
fzf_layout_window['yoffset'] = 0.5
fzf_layout_window['xoffset'] = 0.5
fzf_layout_window['highlight'] = 'Todo'
fzf_layout_window['border'] = 'sharp'
fzf_layout['window'] = fzf_layout_window
g.fzf_layout = fzf_layout

command(
    "command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)")

local function fzf_qf_selected(lines)
    -- This is a total mystery. If you remove this, which theoretically does nothing, you can't do ctrl-q
    print(vim.inspect(lines))
end

local fzf_action = {}
fzf_action['ctrl-t'] = 'tab split'
fzf_action['ctrl-x'] = 'split'
fzf_action['ctrl-v'] = 'vsplit'
fzf_action['ctrl-q'] = fzf_qf_selected
g.fzf_action = fzf_action

setenv('FZF_DEFAULT_OPTS', '--layout=reverse --info=inline --bind ctrl-a:select-all,ctrl-n:down,ctrl-p:up')
setenv('FZF_DEFAULT_COMMAND', 'rg --files --hidden')
