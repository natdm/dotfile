" install plugin manager if not installed
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

call plug#begin('~/.vim/plugged')
" colorscheme
Plug 'rakr/vim-one'
Plug 'sainnhe/everforest'
Plug 'sainnhe/edge'
" searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" lsp
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" languages
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'mattn/emmet-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
" snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" app integrations
Plug 'robbyrussell/oh-my-zsh'
Plug 'christoomey/vim-tmux-navigator'
" motions
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
" patches
" cursorhold: https://github.com/neovim/neovim/issues/12587
Plug 'antoinemadec/FixCursorHold.nvim'
" other
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vim-which-key'
Plug 'vimwiki/vimwiki'
call plug#end()

colorscheme everforest
