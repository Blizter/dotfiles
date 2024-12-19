#! /bin/zsh
set -o emacs

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
source "$HOME/.local/bin/env"

eval "$(oh-my-posh init zsh --config ${HOME}/.custom.omp.toml)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

## Add in snippets
# OMZ Libs
zinit snippet OMZL::git.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::completion.zsh
# OMZ Plugins
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::python
zinit snippet OMZP::sudo

autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Completions
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias k=kubectl
alias kcx=kubectx
alias kns=kubens
alias ls='ls --color'
alias mkd="mkdir -pv"
alias podman="podman-remote-static-linux_amd64"
alias reload="exec zsh"
alias tf=terraform
alias vim="nvim"
alias watch="watch -n 1 "
alias zshconfig="nvim ${HOME}/.zshrc"

## Terraform autocomplete
complete -o nospace -C /home/eric/go/bin/gocomplete go
complete -o nospace -C /home/ehammel/.local/bin/terraform terraform
complete -o nospace -C /home/ehammel/.local/bin/terraform tf
complete -C '/usr/local/bin/aws_completer' aws

eval "$(kind completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(localstack completion zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
eval "$(oh-my-posh completion zsh)"
