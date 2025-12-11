#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#
#Ensure path arrays do not contain duplicates.
set -o emacs

typeset -gU path fpath
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export SECRETS_HOME="${HOME}/.local/secrets"
export HELPERS_HOME="${HOME}/.local/helpers"

# set main editor
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export PATH="${PATH}:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"


export PATH="/usr/bin:/usr/local/bin:/bin:${PATH}"
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# Set ZDOTDIR if you want to re-home Zsh.
export DOCKER_HOST="unix://${XDG_DATA_HOME:-${HOME}/.local/share}/containers/podman/machine/qemu/podman.sock"
export FZF_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/bin"

[ -d "${HOME}/.krew/" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:${PATH}"
[ -d "${HOME}/.local/go/bin" ] && GOPATH="${HOME}/go/" && \
                                GOBIN="${GOPATH}/bin" && \
                                PATH="${GOPATH}:${GOBIN}:${PATH}"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
