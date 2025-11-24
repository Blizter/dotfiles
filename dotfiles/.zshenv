#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!
set -o emacs

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export SECRETS_HOME="${HOME}/.local/secrets/"

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export FZF_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/bin"

# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:/snap/bin:${HOMW}/.local/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

#tfenv path
PATH="${HOME}/local/share/.tfenv/bin:${PATH}"
# go binary variables
[ -d "${HOME}/go/bin" ] && eval "$(go env)" && \
  GOBIN="${GOPATH}/bin" && \
  PATH="${GOPATH}:${GOBIN}:${PATH}"

# set main editor
export EDITOR="nvim"


export PODMAN_SOCK="/home/ehammel/.local/share/containers/podman/machine/qemu/podman.sock"
export DOCKER_HOST="unix://${PODMAN_SOCK}"
