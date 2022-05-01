local map = vim.api.nvim_set_keymap
local g = vim.g
local cmd = vim.cmd

-- helper functions
local function nmap(pattern, action)
    local options = {}
    map('n', pattern, action, options)
end

local function nmapsl(pattern, action)
    local options = {noremap = true, silent = true}
    map('n', '<leader>' .. pattern, action, options)
end

local function nmaps(pattern, action)
    local options = {noremap = true, silent = true}
    map('n', pattern, action, options)
end

local function nmapl(pattern, action)
    local options = {noremap = true}
    map('n', '<leader>' .. pattern, action, options)
end

local function imap(pattern, action)
    local options = {noremap = true}
    map('i', pattern, action, options)
end

local function vmap(pattern, action)
    local options = {noremap = true}
    map('v', pattern, action, options)
end

local function vmapsl(pattern, action)
    local options = {noremap = true, silent = true}
    map('v', '<leader>' .. pattern, action, options)
end

local function vmapl(pattern, action)
    local options = {noremap = true}
    map('v', '<leader>' .. pattern, action, options)
end
-- the next two lines are equivalent to these two:
-- nnoremap <SPACE> <Nop>
-- let mapleader=" "
nmap('<Space>', '')
g.mapleader = ' '

nmap("<C-s>", "<cmd> lua Sig()<CR>")
nmap('<C-c>', ':cclo')

nmap('s', '<Plug>(easymotion-overwin-f)')

nmapsl('fx', ':set hlsearch!<CR>')

-- keep search resuls in the center of the screen. Thanks Primagen
-- n(ext)zz(center cursor)zv(open folds if any)
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- a better way to collapse lines
nmap('J', 'mzJ`z')

-- moving texts around, and also obey indentation rules.. which is awesome
-- This is magic to me, but here is the video: https://www.youtube.com/watch?v=hSHATqh8svM
vmap('J', ':m \'>+1<CR>gv=gv')
vmap('K', ':m \'<-2<CR>gv=gv')

-- save some common breakpoints for undo
imap(',', ',<c-g>u')
imap('.', '.<c-g>u')
imap('!', '!<c-g>u')
imap('?', '?<c-g>u')

-- file explorer
nmapsl('e', ':NvimTreeToggle<CR>')
nmapsl('r', ':NvimTreeRefresh<CR>')

-- prev/next diff and center
nmapl('hh', '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>zz')
nmapl('hH', '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>zz')

-- this could be written better, they have examples for it in gitsigns
-- but it works fine.
nmapl('hp', '<cmd>Gitsigns preview_hunk<CR>')
-- search for files within repo
nmapl('ff', ':Files<CR>')
nmapl('fh', ':History<CR>')
-- search for buffers
nmapl('fu', ':Buffers<CR>')
-- search commits for buffer
nmapl('fb', ':BCommits<CR>')
-- search commits
nmapl('fc', ':Commits<CR>')
-- search git files
nmapl('fg', ':GFiles<CR>')
-- search git files that have changed
nmapl('fG', ':GFiles?<CR>')
-- search lines within a file
nmapl('fl', ':BLines<CR>')
-- search for anything with fzf
nmapl('fz', ':FZF<CR>')
-- this ripgrep is basic and requires more filtering. All hidden files, names
-- of files, etc, are searched
nmapl('fr', ':Rg<CR>')
-- Ripgrep looking at all lines in all files, including hidden, but exclude
-- file names from search
nmapl('fR', ':RG<CR>')
nmapl('fa', ':Ag<CR>')
nmapl('fm', ':Marks<CR>')

nmapsl('rc', ':tabedit /.dotfile/neovimlua/.config/nvim/init.lua<CR>')
nmapsl('ct', ':TagbarToggle<CR>')

nmapsl('bc', 'let @+ = expand("%")<CR>')
nmapsl('u !', 'bcopy < uuidgen<CR>')
-- resizing.. allow range one day

nmapsl('rV', ':exe "vertical resize +10"<CR>')
nmapsl('rv', ':exe "vertical resize -10"<CR>')
nmapsl('rH', ':exe "resize " . (winheight(0) * 3/2)<CR>')
nmapsl('rh', ':exe "resize " . (winheight(0) * 2/3)<CR>')

nmapsl('tn', ':tabnew<CR>')
nmapsl('tx', ':tabclose<CR>')
nmapsl('ts', ':tab split<CR> ')
-- Normalize spacing
-- nmap <silent> <leader>r= <C-W>=
-- Breakout split in to new tab
nmapsl('tb', '<C-W>T')

nmapsl('wsh', ':topleft vnew<CR><ESC>')
nmapsl('wsj', ':botright new<CR><ESC>')
nmapsl('wsk', ':topleft new<CR><ESC>')
nmapsl('wsl', ':botright vnew<CR><ESC>')

-- buffer splits
nmapsl('bsh', ':leftabove vnew<CR><ESC>')
nmapsl('bsj', ':rightbelow new<CR><ESC>')
nmapsl('bsk', ':leftabove new<CR><ESC>')
nmapsl('bsl', ':rightbelow vnew<CR><ESC>')

nmapsl('bf', ':BufOnly<CR> ')

vmapsl('p', '"_dP')

nmap('H', '^')
nmap('L', '$')
vmap('H', '^')
vmap('L', '$')

-- copy the current buffer path
cmd('command! CopyBufferPath let @+ = expand(\'%:p\')')
-- same as above, except it adds the line number
cmd('command! CopyBufferPathL let @+ = expand(\'%:p\') . ":" . ("" . line(".") + 1)')

nmapsl('ybp', ':CopyBufferPath<CR>')
nmapsl('ybl', ':CopyBufferPathL<CR>')

nmapl('cb', ':!open % -a Google\\ Chrome<CR>')

-- lsp-specific settings
nmap('gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
nmaps('gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
nmaps('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nmaps('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nmaps('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
nmaps('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- nmaps('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmapsl('cdn', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
nmapsl('cdp', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
nmapl('rr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>:e<CR>')

nmaps('<C-h>', '<C-w><C-h>')
nmaps('<C-j>', '<C-w><C-j>')
nmaps('<C-k>', '<C-w><C-k>')
nmaps('<C-l>', '<C-w><C-l>')
nmaps('<C-p>', '<cmd> lua PullsGetComments()<CR>')
nmaps('<C-l>', '<cmd> lua PullsLoadCommentsForLine()<CR>')

nmaps(']]', '<cmd> lua IncWidth()<CR>')
nmaps('[[', '<cmd> lua DecWidth()<CR>')
nmaps('}}', '<cmd> lua IncHeight()<CR>')
nmaps('{{', '<cmd> lua DecHeight()<CR>')

nmapsl("pr", '<cmd>lua require("pulls").reviews()<CR>')
nmapsl("pi", '<cmd>lua require("pulls").issues()<CR>')
nmapsl("pc", '<cmd>lua require("pulls").comments()<CR>')
nmapsl("pt", '<cmd>lua require("pulls").tag_window()<CR>')
nmapsl("pu", '<cmd>lua require("pulls").untag_window()<CR>')
nmapsl("pd", '<cmd>lua require("pulls").description()<CR>')
nmapsl("pp", '<cmd>lua require("pulls").diff()<CR>')
nmapsl("pn", '<cmd>lua require("pulls").diff_next()<CR>')
nmapsl("pl", '<cmd>lua require("pulls").changes()<CR>')
nmapsl("ph", '<cmd>lua require("pulls").highlight_changes()<CR>')

-- diagnostics
nmapsl("dw", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>")
nmapsl("dd", "<cmd>TroubleToggle lsp_document_diagnostics<CR>")
nmapsl("dr", "<cmd>TroubleToggle lsp_references<CR>")
nmapsl("dl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")

nmapsl("ht", '<cmd>so $VIMRUNTIME/syntax/hitest.vim<CR>')

nmapsl("ss", '<cmd>Switch<CR>')
-- co for Code Outline
nmapsl("co",'<cmd>SymbolsOutline<CR>')
-- shortcut to reload luasnip on changes
nmap("<leader><leader>s", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>")
-- nmapl('crn', '<Plug>(coc-rename)')
-- vmapl('cm', '<Plug>(coc-format-selected)')
-- nmapl('cm', '<Plug>(coc-format-selected)')
-- vmapl('a', '<Plug>(coc-codeaction-selected)')
-- nmapl('a', '<Plug>(coc-codeaction-selected)')
-- nmapl('ca', '<Plug>(coc-codeaction)')
-- nmapl('cf', '<Plug>(coc-fix-current)')
-- nmapl('crf', '<Plug>(coc-references)')
-- nmapl('cdp', '<Plug>(coc-diagnostic-prev)')
-- nmapl('cdn', '<Plug>(coc-diagnostic-next)')
-- nmapl('cds', ':CocDiagnostics<CR>')
-- nmapsl('e', ':CocCommand explorer<CR>')
-- -- Remap keys for gotos
-- nmap('gd', '<Plug>(coc-definition)')
-- nmap('gy', '<Plug>(coc-type-definition)')
-- nmap('gi', '<Plug>(coc-implementation)')
-- nmap('gr', '<Plug>(coc-references)')

-- function show_documentation()
-- local filetype = vim.bo.filetype

-- if filetype == 'vim' or filetype == 'help' then
-- vim.api.nvim_command('h ' .. filetype)
-- else
-- todo: LSP
-- vim.fn.CocActionAsync('doHover')
-- end
-- end

-- function _G.smart_scroll_f()
--     return vim.fn['coc#float#has_scroll']() and vim.fn['coc#float#scroll'](1) or t'<C-f>'
-- end

-- function _G.smart_scroll_b()
--     return vim.fn['coc#float#has_scroll']() and vim.fn['coc#float#scroll'](0) or t'<C-b>'
-- end

-- maybe this is a better way, since this won't work...
-- https://github.com/kristijanhusak/neovim-config/blob/bleeding-edge/nvim/lua/partials/completion.lua#L52
-- map('n', '<c-f>', 'v:lua.smart_scroll_f()', {nowait = true, expr = true})
-- map('n', '<c-b>', 'v:lua.smart_scroll_b()', {nowait = true, expr = true})
