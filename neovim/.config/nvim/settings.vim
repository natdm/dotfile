filetype plugin indent on
set timeoutlen=500
set nocompatible
set visualbell
set number relativenumber
"update git gutter time, reload status faster
set updatetime=100
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set noswapfile
set cursorline
set termguicolors
set cmdheight=2
set encoding=UTF-8
"set foldcolumn=3
if has("nvim")
  set inccommand=nosplit
endif
" creating and setting undo
if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

set smartcase
set ignorecase
set splitright
set splitbelow
set wrap
set linebreak
set lazyredraw
set hlsearch
set noshowmode
set scrolloff=5
set sidescrolloff=5
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
set tabstop=2
" opaque background, which would then just use your term emulators bg
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none
" highlight Normal guibg=none
" highlight NonText guibg=none
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
"autocmd FileType yaml,json,make call SetWhitespace()

function SetWhitespace()
  " this seems to have a bug, where it always gets set
  set listchars=eol:¬,tab:>.,trail:~,extends:>,precedes:<,space:.
  set list
endfunction

" this make the popup menu a bit moree intuitive -- without it, if you have
" a snippet and something is trying to autocomplete, if you <esc> it, it kills
" the snippet.
" .. but with it, esc is really slow..
" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" let g:indentLine_char = '⦙'

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" toggle tmux status bar in vim
" https://www.reddit.com/r/vim/comments/lgdmfx/simple_and_elegant_way_to_toggle_tmux_status_bar/
" Playing with it for now, may not like it
" if has_key(environ(), 'TMUX')
"   augroup HideTmuxInVim
"     autocmd VimResume,VimEnter * call system('tmux set status off')
"     autocmd VimSuspend,VimLeave * call system('tmux set status on')
"   augroup END
" endif
"
