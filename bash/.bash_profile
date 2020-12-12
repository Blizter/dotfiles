#! /bin/bash

# Preferred editor for local and remote sessions

# set main editor
export EDITOR="vim"
# local bin path
export PATH=${PATH}:${HOME}/.local/bin
# go binary variables
export PATH=${PATH}:/usr/local/go/bin
#pyenv python binaries
export PATH="${HOME}/.pyenv/bin:${PATH}"

[ -f ${HOME}/.bashrc ] && source ${HOME}/.bashrc && echo "config reloaded"
