# ==========================================
# ZSHRC — interactive shell settings
# ==========================================

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git asdf zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
source $ZSH/oh-my-zsh.sh

# Shell options
setopt HIST_IGNORE_SPACE

# Aliases

# Git
alias standup="git log --since='yesterday.midnight' --all --no-merges --oneline --author=fvaagaard@gmail.com"

# Neovim
alias vim=nvim

# TMUX
alias ta="$HOME/bin/tmuxdefault.sh"
alias td="tmux detach"
alias tk="tmux kill-session -t scout-portal-dev"

# Github Copilot CLI
alias ghe="gh copilot explain"
alias ghs="gh copilot suggest"

# Gemini CLI
alias g="gemini"
alias gp="gemini -p"

# Kubectl / Helm
#source <(kubectl completion zsh)
alias docker-compose="docker compose"
alias k=kubectl
alias kd="kubectl describe"
alias kn="kubectl -n scout-portal"
alias kc="kubectl config get-contexts"
alias kcs="kubectl config use-context AKS-Staging && kubectl config get-contexts"
alias kcp="kubectl config use-context AKS-Prod && kubectl config get-contexts"

alias h="helm"
alias hn="helm -n scout-portal"

# Stern completion
#source <(stern --completion=zsh)

# Console Ninja
#PATH=~/.console-ninja/.bin:$PATH

# Python / Conda (conda init block can remain here)
#__conda_setup="$('/home/fredrik/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/fredrik/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/fredrik/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/fredrik/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup

