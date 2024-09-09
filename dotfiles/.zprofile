#! /bin/zsh
# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:${KREW_ROOT:-$HOME/.krew}/bin:${PATH}"
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
eval "$(fzf --zsh)"

export DOCKER_HOST='unix:///Users/eric.hammel/.local/share/containers/podman/machine/qemu/podman.sock'

# pyenv python binaries
[ -d "${HOME}/.pyenv/bin" ] &&  PYENV_ROOT="${HOME}/.pyenv"; \
                                PATH="${PYENV_ROOT}/bin:${PATH}"; \
                                eval "$(pyenv init -)" ; \
                                eval "$(pyenv init --path)" ; \
                                eval "$(pyenv virtualenv-init -)"

[ -d "${HOME}/.secrets/" ] && source "${HOME}/.secrets/env.sh"; echo "secrets loaded"

[ -f "${HOME}/.zshrc" ] && source "${HOME}/.zshrc"

[ -d "${HOME}/.rye/" ] && source "$HOME/.rye/env"

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/eric.hammel/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.23%252B9/OpenJDK11U-jdk_aarch64_mac_hotspot_11.0.23_9.tar.gz/jdk-11.0.23+9/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/eric.hammel/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
