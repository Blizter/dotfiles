#! /bin/zsh
# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# go binary variables
[ -d "${HOME}/.local/go/bin" ] && GOPATH="${HOME}/.local/go/" && \
                                GOBIN="${GOPATH}/bin" && \
                                PATH="${GOPATH}:${GOBIN}:${PATH}"\

# pyenv python binaries
[ -d "${HOME}/.pyenv/bin" ] &&  PYENV_ROOT="${HOME}/.pyenv" && \
                                PATH="${PYENV_ROOT}/bin:${PATH}" && \
                                eval "$(pyenv init --path)" && \
                                eval "$(pyenv init -)" && \
                                eval "$(pyenv virtualenv-init -)"

[ -d "${HOME}/.poetry/bin" ] && PATH="${HOME}/.poetry/bin:${PATH}"

# set main editor
export EDITOR="nvim"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(saml2aws --completion-script-zsh)"

export DOCKER_HOST='unix:///Users/eric.hammel/.local/share/containers/podman/machine/qemu/podman.sock'

# pyenv python binaries
[ -d "${HOME}/.pyenv/bin" ] &&  PYENV_ROOT="${HOME}/.pyenv"; \
                                PATH="${PYENV_ROOT}/bin:${PATH}"; \
                                eval "$(pyenv init -)" ; \
                                eval "$(pyenv init --path)" ; \
                                eval "$(pyenv virtualenv-init -)"


[ -f "${HOME}/.zshrc" ] && source "${HOME}/.zshrc"

