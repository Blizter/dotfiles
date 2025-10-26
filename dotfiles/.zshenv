#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!
set -o emacs

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_RUNTIME_DIR="/run/user/1000"
export FZF_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/bin"

export SECRETS_HOME="${HOME}/.local/secrets/"
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export DOCKER_HOST="unix:$XDG_RUNTIME_DIR/podman/podman.sock"


# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# go binary variables
[ -d "${HOME}/go/bin" ] && eval "$(go env)" && \
  GOBIN="${GOPATH}/bin" && \
  PATH="${GOPATH}:${GOBIN}:${PATH}"
# set main editor
export EDITOR="nvim"
