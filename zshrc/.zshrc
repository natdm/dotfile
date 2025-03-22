# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Ignore anything (for history) that has a space infront of it
setopt HIST_IGNORE_SPACE
setopt auto_cd
# this doesn't seem to work
export EDITOR=nvim
export VISUAL=nvim
export GO_BINARIES="/Users/$(whoami)/go/bin"
export PATH="$PATH:$DOOM_PATH:$GO_BINARIES"
export FZF_PATH="/usr/local/bin/fzf"
export FZF_DEFAULT_COMMAND="rg --files --hiden"
export FZF_DEFAULT_OPS="-m --layout=reverse --info=inline --bind ctrl-a:select-all,ctrl-n:down,ctrl-p:up --color=bg+:#2c323c,spinner:#c678dd,hl:#5c6370,fg:#abb2bf,header:#5c6370,info:#e5c07b,pointer:#c678dd,marker:#e06c75,fg+:#abb2bf,prompt:#c678dd,hl+:#c678dd"
export TERM="xterm-256color"
[ -f ~/.env ] && source ~/.env
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom_agnoster" # change to 'random' for fun
# other good ones..
# fletcherm which is basic and doesn't show much
# agnoster has beat arrows, but still a machineame
# kolo is suuuuuper basic
# lambda is neat, just branch and folder (current favorite)

export ZSH_CUSTOM="/Users/$(whoami)/.oh-my-zsh/custom"

setopt inc_append_history_time

autoload -Uz compinit
compinit

# Required executables or scripts
[[ -d "$ZSH_CUSTOM/plugins/forgit" ]] || git clone https://github.com/wfxr/forgit.git $ZSH_CUSTOM/plugins/forgit
# Check for any work specific sourcefiles
[[ -f "$HOME/.localrc" ]] && source "$HOME/.localrc"
[[ -f "$HOME/.personal" ]] && source "$HOME/.personal"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git forgit z zsh-alias-finder npm)
# Git plugins: https://jasonm23.github.io/oh-my-git-aliases.html

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Exampl aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Autocompletion for kubectl, but add the bracketed condition to not interfere with zsh
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

# Enable this for vim mode, but I did kind of find it annoying
# bindkey -v

# Not really sure if this is needed, but keep it just in case
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 

# source any work-related env
[ -f ~/.work ] && source ~/.work

# Force a tmux session, https://fedoramagazine.org/4-tips-better-tmux-sessions/
# if [ -z "$TMUX" ]; then
# 	tmux attach -t default || tmux new -s default
# fi
setopt inc_append_history_time
#shopt -s autocd # cd by typing a dirs name
export PATH="/usr/local/sbin:/usr/local/opt/libpq/bin:$HOME/scripts:$PATH"
export PATH="$HOME/tools/lua-language-server/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"
export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"
export PATH="$PATH:/Users/nathanhyland/.temporalio/bin"

# function to show the last exit code of the function ran, on the right side of the terminal
function check_last_exit_code() {
	local LAST_EXIT_CODE=$?
	if [[ $LAST_EXIT_CODE -ne 0 ]]; then
		local EXIT_CODE_PROMPT=' '
		EXIT_CODE_PROMPT+="%{$fg[red]%}^%{$reset_color%}"
		EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
		EXIT_CODE_PROMPT+="%{$fg[red]%}^%{$reset_color%}"
		echo "$EXIT_CODE_PROMPT"
	fi
}

# download and source fzf-docker
[[ -d "$HOME/.docker/fzf-docker" ]] || git clone https://github.com/MartinRamm/fzf-docker.git $HOME/.docker/fzf-docker

# RPROMPT is the right side of the zsh prompt
RPROMPT='$(check_last_exit_code)'

# source ~/.zshplugins/fzf-tab/fzf-tab.plugin.zsh
source ~/.custom-alias
[ -f ~/.asdf/asdf.sh ] && . $HOME/.asdf/asdf.sh
[ -f ~/.asdf/completions/asdf.bash ] && . $HOME/.asdf/completions/asdf.bash
[ -f ~/.docker/fzf-docker ] && . $HOME/.docker/fzf-docker/docker-fzf
[ -f /tmp/bb-zsh-autocomplete ] && source /tmp/bb-zsh-autocomplete

alias luamake=/Users/Nathan.Hyland/.lua/lua-language-server/3rd/luamake/luamake

alias py="python3"

git config --global push.default current
git config --global diff.tool nvimdiff
git config --global difftool.prompt true
git config --global difftool.nvimdiff.cmd "nvim -d \"$LOCAL\" \"$REMOTE\""
git config --global core.editor nvim

compdef _bb bb
## add completion for zsh to any cobra autcomplete. Requires https://github.com/lincheney/fzf-tab-completion#zsh cloned to home dir.
source $HOME/fzf-tab-completion/zsh/fzf-zsh-completion.sh && bindkey '^I' fzf_completion


# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr

setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use --silent
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
