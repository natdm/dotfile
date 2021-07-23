" WhichKey {{{
" assign the map to whichkey.
call which_key#register('<Space>', "g:which_key_map")
let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]

let g:user_emmet_leader_key='<C-Z>'

let g:cursorhold_updatetime = 100

" this changes the color of alternating indentations for indent_guidelines.
" It's only activated for a few files, but it's annoying if it's too much.
let g:indent_guides_color_change_percent = 4

" Define prefix dictionary
let g:which_key_map = {
      \ 'b': {'name':'+buffers'},
      \ 'c': {'name':'+code'},
      \ 'd': {'name':'+debug'},
      \ 'f': {'name':'+find'},
      \ 'g': {'name':'+golang'},
      \ 'h': {'name':'+git-hunk'},
      \ 'j': {'name':'+json'},
      \ 'p': {'name':'+project'},
      \ 'r': {'name':'+resizing'},
      \ 't': {'name':'+tabs'},
      \ 'w': {'name':'+window'},
      \ 'y': {'name':'+yaml/yank'},
      \}
" }}}

" Netrw {{{
let loaded_netrwPlugin = 1
" this will unload netrw, so it won't run
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" }}}

" Searching {{{
imap <c-x><c-f> <plug>(fzf-complete-path)

" This is to toggle incremental highlighting from searches done with /
" THERE ARE MORE SETTINGS IN COC
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_preview_window = ['up:40%', 'ctrl-/']
let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {
      \ 'up':'~90%',
      \ 'window': {
        \ 'width': 0.8,
        \ 'height': 0.8,
        \ 'yoffset':0.5,
        \ 'xoffset': 0.5,
        \ 'highlight': 'Todo',
        \ 'border': 'sharp',
        \ }
        \ }

" this is janky -- I have ctrl-a set to the prefix for tmux, instead of
" ctrl-b. So I'll use ctrl-b here to select all in a find.
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --bind ctrl-a:select-all,ctrl-n:down,ctrl-p:up'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \}

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ }

"Get Files
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Ripgrep advanced, which shows file names but will ignore them in search
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

" Git grep
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" }}}

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
"This is a workaround for easymotion trigging coc's disgnostics

" this helps easymotion not disturb diagnostics
" https://github.com/neoclide/coc.nvim/issues/110#issuecomment-631868877
let g:easymotion#is_active = 0
function! EasyMotionCoc() abort
  if EasyMotion#is_active()
    let g:easymotion#is_active = 1
    CocDisable
  else
    if g:easymotion#is_active == 1
      let g:easymotion#is_active = 0
      CocEnable
    endif
  endif
endfunction
autocmd TextChanged,CursorMoved * call EasyMotionCoc()
" }}}

" UndoTree Settings {{{
" undotree has a gross default layout
let g:undotree_WindowLayout = 1

" e.g. using 'd' instead of 'days' to save some space.
let g:undotree_ShortIndicators = 1

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
let g:undotree_SetFocusWhenToggle = 1

" relative timestamp
let g:undotree_RelativeTimestamp = 1

" Highlight changed text
let g:undotree_HighlightChangedText = 1

if g:undotree_ShortIndicators == 1
  let g:undotree_SplitWidth = 30
else
  let g:undotree_SplitWidth = 35
endif
" }}}

" Scrolling {{{
" It looks like there's a collision between comfortable motions use of C-[fbdu]
" and coc's scrolling code. Use the comfortable_motion_no_default_key_mappings
" variable to stop those mappings and manually add the ones I want, then call
" the others manually in the ternary for c[d/u] in coc scrolling.
" ref: https://github.com/yuttie/comfortable-motion.vim#keys-and-mouse-wheel
let g:comfortable_motion_no_default_key_mappings = 1

" just change these variables for the flick speeds -- higher is faster, but
" they have to work with the friction and air_drag to feel right.
let flickspeed = 3200
let flickspeed_half = flickspeed/2
let g:comfortable_motion_friction = 16000.0
let g:comfortable_motion_air_drag = 12.0

nnoremap <silent> <C-f> :call comfortable_motion#flick(flickspeed)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(flickspeed-(flickspeed*2))<CR>
" nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
" }}}

" Coc Settings {{{
" scrolling
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : ":call comfortable_motion#flick(flickspeed_half)<CR>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : ":call comfortable_motion#flick(flickspeed_half-(flickspeed_half*2))<CR>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : ":call comfortable_motion#flick(flickspeed_half)<CR>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : ":call comfortable_motion#flick(flickspeed_half-(flickspeed_half*2))<CR>"

" coc extensions should be added here, not manually, to ensure they're
" installed on other machines.
let g:coc_global_extensions = [
      \	'coc-json',
      \ 'coc-elixir',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-go',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-ultisnips',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \]

" Use <c-space> to trigger completion. Disabled since this is used for macvin
" inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K shows documentation
" It looks like, for go, it shows in the help area. All else, it shows over
" code
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" CocSnippets {{{
let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/ultisnips"
" This was interfering with coc pumenu, so I set it to something I don't use
" and it seems to work fine with tab anyways??
let g:UltiSnipsExpandTrigger="<c-p>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <expr> <TAB> pumvisible() ? "\<c-y>" : "\<tab>"

" ctrl-[n/p] to scroll menu, then tab to complete.
" ctrl-[j/k] to nav through snippet pieces
" }}}

" Custom Mappings {{{
" re-source when vimrc changes
autocmd! bufwritepost .vimrc source %

" No more ex mode, just re-run the last macro
nnoremap Q @@

" Custom abbreviations
iabbrev teh the

" Bgone arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" make saving easier, save straight from insert or normal mode
inoremap <silent> <c-w> <ESC>:w<CR>a
nnoremap <silent> <c-w> :w<CR>

" for the lazy, escape faster
imap jk <Esc>
imap kj <Esc>

" tab colors
hi TabLine gui=NONE guibg=#3e4452 guifg=#abb2bf cterm=NONE term=NONE ctermfg=black ctermbg=white
hi TabLineSel gui=NONE guibg=#85d3f2 guifg=#2c2e34 cterm=NONE term=NONE ctermfg=235 ctermbg=110
" }}}

" function! s:flash_screen()
" 	echom "enter window"
" endfunction

" autocmd WinEnter * call s:flash_screen()
" Vimwiki {{{
let g:vimwiki_list = [{
      \ 'path': '~/wiki/',
      \ 'syntax': 'markdown',
      \ 'ext': 'md',
      \ 'path_html': '~/wiki_html',
      \ }]
let g:vimwiki_markdown_link_ext = 1
" }}}

