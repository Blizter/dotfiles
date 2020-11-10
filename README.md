# dotfiles

set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based wrkflow as explained in this (article)[https://erichammel.xyz/posts/going-terminal-based/] on my blog

## Pre-req
First, install the following packages/libraries : 
  -  tmux
  -  vim
  -  [oh-my-bash](https://github.com/ohmybash/oh-my-bash)

then create symlinks for the different dotfiles :
```bash
    ln -sv ~/Projects/dotfiles/bash/.bash_profile ~
    ln -sv ~/Projects/dotfiles/bash/.bashrc ~
    ln -sv ~/Projects/dotfiles/tmux/.tmux.conf ~
    ln -sv ~/Projects/dotfiles/vim/.vimrc ~
```

## Bash
Contains bashrc and `bash_profile`

## tmux/
tmux config file

## vim/
contains `.vimrc` and a script to install plugins using vim8+ native plugin flow.

