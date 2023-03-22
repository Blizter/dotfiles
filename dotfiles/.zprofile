#! /bin/zsh
# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/bin" ] && PATH="${HOME}/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# go binary variables
[ -d "/usr/local/go/bin" ] && GOPATH="${HOME}/go"; \
                              GOBIN="${GOPATH}/bin"; \
                              PATH="/usr/local/go/bin:${GOPATH}:${GOBIN}:${PATH}"; \

# pyenv python binaries
[ -d "${HOME}/.pyenv/bin" ] &&  PYENV_ROOT="${HOME}/.pyenv"; \
                                PATH="${PYENV_ROOT}/bin:${PATH}"; \
                                eval "$(pyenv init --path)" ; \
                                eval "$(pyenv init -)" ; \
                                eval "$(pyenv virtualenv-init -)"

[ -d "${HOME}/.tfenv/bin" ] &&  PATH="${HOME}/.tfenv/bin:${PATH}"

[ -d "${HOME}/.poetry/bin" ] && PATH="${HOME}/.poetry/bin:${PATH}"

# set main editor
export EDITOR="nvim"
export MYVIMRC=${HOME}/.config/nvim/init.vim

# Nvidia cuda cli tool
export PATH=/usr/local/cuda-11.3/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

[ -f "${HOME}/.zshrc" ] && source "${HOME}/.zshrc"
