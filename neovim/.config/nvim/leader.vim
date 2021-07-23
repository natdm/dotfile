" Set any leader mappings in here
" Whichkey is also set here

nnoremap <SPACE> <Nop>
let mapleader=" "

" assign the map to whichkey.  
call which_key#register('<Space>', "g:which_key_map")

let g:which_key_map = {
      \ 'w': {'name':'+window'}, 
      \ 'p': {'name':'+project'}, 
      \ 'd': {'name':'+debug'}, 
      \ 'h': {'name':'+git-hunk'}, 
      \ 'l': {'name':'+language'}, 
      \ 'y': {'name':'+yaml/yank'}, 
      \ 'c': {'name':'+code'}, 
      \ 'r': {'name':'+resizing'}, 
      \ 'b': {'name':'+buffers'}, 
      \ 't': {'name':'+tabs'}, 
      \ 'f': {'name':'+find'}, 
      \ 'g': {'name':'+golang'}, 
      \}

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

let g:which_key_map.s = 'Source ini'
nnoremap <silent> <leader>s :source ~/.config/nvim/init.vim<CR>

" easymotion prefix, j for jump
map <leader>j <Plug>(easymotion-overwin-f)
let g:which_key_map.j = 'Jump (easymotion)'

" git
nnoremap <leader>hh :GitGutterNextHunk<CR>
nnoremap <leader>hH :GitGutterPrevHunk<CR>
nnoremap <leader>hp :GitGutterPreviewHunk<CR>

" window navigation
nnoremap <leader>ww :WMSwap<CR>
let g:which_key_map.w.w = 'Swap with window'
nnoremap <leader>wf :WMSwapAndFollow<CR>
let g:which_key_map.w.f = 'Swap with window and follow'
nnoremap <leader>wn :WMNav<CR>
let g:which_key_map.w.n = 'Navigate to window'
nnoremap <leader>wx :WMDelete<CR>
let g:which_key_map.w.x = 'Close window'

" searching
nnoremap <silent> <leader>fx :set hlsearch!<CR>
let g:which_key_map.f.x = 'Cancel Highlight'
" search for files within repo
map <leader>ff :Files<CR>
" search for buffers
map <leader>fu :Buffers<CR>
" search commits for buffer
map <leader>fb :BCommits<CR>
" search commits
map <leader>fc :Commits<CR>
" search git files
map <leader>fg :GFiles<CR>
" search git files that have changed
map <leader>fG :GFiles?<CR>
" search lines within a file
map <leader>fl :BLines<CR>
" search for anything with fzf
map <leader>fz :FZF<CR>
" this ripgrep is basic and requires more filtering. All hidden files, names
" of files, etc, are searched
nnoremap <leader>fr :Rg<CR>
" Ripgrep looking at all lines in all files, including hidden, but exclude
" file names from search
nnoremap <leader>fR :RG<CR>
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fm :Marks<CR>

" (c)ode (d)iagnostics
let g:which_key_map.c.d = {'name':'+diagnostics'}
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>

" Remap for rename current word
nmap <leader>crn <Plug>(coc-rename)
let g:which_key_map.c['rn'] = 'Rename'

" Remap for format selected region
vmap <leader>cm <Plug>(coc-format-selected)
nmap <leader>cm <Plug>(coc-format-selected)
let g:which_key_map.c.m = 'For(m)at'

" RemapTestPartnerService_DeleteLayout(t f rsier tab navigation:q do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
let g:which_key_map.a = 'Code Action Selected'

nmap <leader>ca  <Plug>(coc-codeaction)
let g:which_key_map.c.a = 'Action'
" Fix autofix problem of current line
nmap <leader>cf  <Plug>(coc-fix-current)
let g:which_key_map.c.f = 'Fix Current'

nmap <leader>crf  <Plug>(coc-references)
let g:which_key_map.c['rf'] = 'References'


nmap <silent> <leader>cdp <Plug>(coc-diagnostic-prev)
let g:which_key_map.c.d.p = "Previous Diagnostic"
nmap <silent> <leader>cdn <Plug>(coc-diagnostic-next)
let g:which_key_map.c.d.n = "Next Diagnostic"
nmap <silent> <leader>cds :CocDiagnostics<CR>
let g:which_key_map.c.d.s = "Show Diagnostics"

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

nmap <silent><nowait> <leader>e :CocCommand explorer<CR>
let g:which_key_map.e = 'Toggle Explorer'

" }}}

" Executable Shortcuts {{{
" format json doc
" nmap <silent><leader>ljq :%!jq --indent 4 .<CR> 
" let g:which_key_map.l.j.q = "Format JSON"
" " format yaml doc
" nmap <silent><leader>lyq :%!yq -y .<CR>
" let g:which_key_map.l.y.q = "Format YAML"
" " format yaml to json
" nmap <silent><leader>lyj :%!yq .<CR>
" let g:which_key_map.l.y.j = "Formt YAML as JSON"
" " Minify JSON
" nmap <silent><leader>ljm :%!jq -c .<CR>
" let g:which_key_map.l.j.m = "Minify JSON"
" }}}

" Split vimrc for easier editing
nmap <silent> <leader>rc :tabedit ~/.dotfiles/neovim/.config/nvim/init.vim<CR>
" Toggle Tagbar
nmap <silent> <leader>ct :TagbarToggle<CR>

nmap <silent> <leader>yc "+y<CR>
let g:which_key_map.y.c = "Yank to clipboard"

" generate a uuid at the cursor
nnoremap <silent> <leader>u !pbcopy < uuidgen<CR>
let g:which_key_map.u = "Generate UUID"
" resizing.. allow range one day

nnoremap <silent> <Leader>rV :exe "vertical resize +10"<CR>
let g:which_key_map.r.V = 'Vertical +10'
nnoremap <silent> <Leader>rv :exe "vertical resize -10"<CR>
let g:which_key_map.r.r = 'Vertical -10'
nnoremap <silent> <Leader>rH :exe "resize " . (winheight(0) * 3/2)<CR>
let g:which_key_map.r.H = 'Horizontal +10'
nnoremap <silent> <Leader>rh :exe "resize " . (winheight(0) * 2/3)<CR>
let g:which_key_map.r.h = 'Horizontal -10'

nmap <silent> <leader>tn :tabnew<CR>
let g:which_key_map.t.n = 'New'
nmap <silent> <leader>tx :tabclose<CR>
let g:which_key_map.t.x = 'Close'
nmap <silent> <leader>ts :tab split<CR> 
let g:which_key_map.t.s = 'Dunno'
" Normalize spacing
" nmap <silent> <leader>r= <C-W>=
" let g:which_key_map.r["="] = 'Equalize'
" Breakout split in to new tab
nmap <silent> <leader>tb <C-W>T
let g:which_key_map.t.b = 'Breakout'

let g:which_key_map.w.s = {"name":"+split"}
nmap <silent> <leader>wsh :topleft vnew<CR><ESC>
let g:which_key_map.w.s.h = "Left"
nmap <silent> <leader>wsj :botright new<CR><ESC>
let g:which_key_map.w.s.j = "Down"
nmap <silent> <leader>wsk :topleft new<CR><ESC>
let g:which_key_map.w.s.k = "Up"
nmap <silent> <leader>wsl :botright vnew<CR><ESC>
let g:which_key_map.w.s.l = "Right"

" buffer splits
let g:which_key_map.b.s = {"name":"+split"}
nmap <silent> <leader>bsh :leftabove vnew<CR><ESC>
let g:which_key_map.b.s.h = "Left"
nmap <silent> <leader>bsj :rightbelow new<CR><ESC>
let g:which_key_map.b.s.j = "Down"
nmap <silent> <leader>bsk :leftabove new<CR><ESC>
let g:which_key_map.b.s.k = "Up"
nmap <silent> <leader>bsl :rightbelow vnew<CR><ESC>
let g:which_key_map.b.s.l = "Right"

nmap <silent> <leader>bf :BufOnly<CR> 
let g:which_key_map.b.f = "Focus (delete others)"

" copy the current buffer path
command! CopyBufferPath let @+ = expand('%:p')

nmap <CopyBufferPath> <leader>bc :CopyBufferPath<CR>
let g:which_key_map.b.c = "Copy path to clipboard"

" v-select something to paste over, then leader-p to paste
vnoremap <leader>p "_dP

" git diff setup
"
function! s:load_git_settings()
  " short for 'git diff' then f for left side and j for right side, like
  " primagen!
  let g:which_key_map.g['df'] = "Merge left conflict"
  let g:which_key_map.g['dj'] = "Merge right conflict"
  nmap <leader>gdf :diffget //2<CR>
  nmap <leader>gdj :diffget //3<CR>
endfunction

" since 'g' is also used for go (which I should change), only use this if the
" filetype is vim
autocmd FileType vim call s:load_git_settings()
