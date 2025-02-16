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
export FZF_BASE="${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/bin"

export SECRETS_HOME="${HOME}/.local/secrets/"

# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:/snap/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# go binary variables
[ -d "${HOME}/.local/go/bin" ] && GOPATH="${HOME}/.local/go/" && \
                                GOBIN="${GOPATH}/bin" && \
                                PATH="${GOPATH}:${GOBIN}:${PATH}"
# set main editor
export EDITOR="nvim"

# Nvidia cuda cli tool
export PATH=/usr/local/cuda/bin:$PATH
export CUDA_ROOT=/usr/local/cuda
export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export KIND_EXPERIMENTAL_PROVIDER='podman'

# >>> coursier install directory >>>
export PATH="$PATH:/${HOME}/.local/share/coursier/bin"
# <<< coursier install directory <<<
