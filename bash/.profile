#! /bin/bash

# Preferred editor for local and remote sessions

# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/bin:${PATH}"

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="/usr/bin:/bin:${HOME}/bin:${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

# go binary variables
if [ -d "/usr/local/go/bin" ] ; then
    PATH="PATH=/usr/local/go/bin:${PATH}"
fi

#pyenv python binaries
if [ -d "${HOME}/.pyenv/bin" ] ; then
    PATH="${HOME}/.pyenv/bin:${PATH}"
fi

# set main editor
export EDITOR="vim"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
    # includes work specific funtions, aliases, env_vars
    # not needed on my personal machines
    if [ -a "${HOME}/.work_specific" ] ; then
        . "${HOME}/.work_specific"
    fi

fi
