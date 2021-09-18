#! /bin/bash

# Preferred editor for local and remote sessions

# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/bin" ] && PATH="/usr/bin:/bin:${HOME}/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# go binary variables
[ -d "/usr/local/go/bin" ] && GOPATH="${HOME}/go"; \
                                PATH="/usr/local/go/bin:${PATH}"


#pyenv python binaries
[ -d "${HOME}/.pyenv/bin" ] && PATH="${HOME}/.pyenv/bin:${PATH}"; \
                                eval "$(pyenv init --path)" ; \
                                eval "$(pyenv init -)" ; \
                                eval "$(pyenv virtualenv-init -)"

 set main editor
export EDITOR="vim -u ~/.vimrc"

# Nvidia cuda cli tool
export PATH=/usr/local/cuda-11.3/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# if running bash
[ -n "$BASH_VERSION" ] &&\
    { [ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"; } ;\
    { [ -a "${HOME}/.work_specific" ] && source "${HOME}/.work_specific" || true ; }
