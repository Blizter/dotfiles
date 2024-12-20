#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#
#Ensure path arrays do not contain duplicates.
set -o emacs

typeset -gU path fpath
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
# set main editor
export EDITOR="nvim"
export PATH="/usr/bin:/usr/local/bin:/bin:${PATH}"
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

export SECRET_HOME="${HOME}/.local/secrets"
# Set ZDOTDIR if you want to re-home Zsh.
export DOCKER_HOST='unix:///Users/eric.hammel/.local/share/containers/podman/machine/qemu/podman.sock'
export FZF_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/bin"

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

[ -d "${HOME}/.krew/" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:${PATH}"
[ -d "${HOME}/.local/go/bin" ] && GOPATH="${HOME}/.local/go/" && \
                                GOBIN="${GOPATH}/bin" && \
                                PATH="${GOPATH}:${GOBIN}:${PATH}"
# >>> coursier install directory >>>
export PATH="$PATH:/${HOME}/.local/share/coursier/bin"
# <<< coursier install directory <<<
