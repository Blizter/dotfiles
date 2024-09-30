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

[ -d "${HOME}/.rye" ] && source "${HOME}/.rye/env" && \
                        PATH="${HOME}/.rye/shims:${PATH}"

# set main editor
export EDITOR="nvim"

# Nvidia cuda cli tool
export PATH=/usr/local/cuda/bin:$PATH
export CUDA_ROOT=/usr/local/cuda
export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export KIND_EXPERIMENTAL_PROVIDER='podman-remote-static-linux_amd64'

# >>> coursier install directory >>>
export PATH="$PATH:/${HOME}/.local/share/coursier/bin"
# <<< coursier install directory <<<

source /${HOME}/.secrets/secrets.sh
[ -f "${HOME}/.zshrc" ] && source "${HOME}/.zshrc"
