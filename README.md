# dotfiles

set of dotfiles to configure my environments


## Pre-req
First, install the following packages/libraries : 
  -  tmux
  -  vim
  -  (oh-my-bash)[https://github.com/ohmybash/oh-my-bash]

then create symlinks for the different dotfiles :

```bash

    ln -sv ~/Projects/dotfiles/bash/.bash_profile ~
    ln -sv ~/Projects/dotfiles/bash/.bashrc ~
    ln -sv ~/Projects/dotfiles/tmux/.tmux.conf ~
    ln -sv ~/Projects/dotfiles/vim/.vimrc ~

```

## bash/
Contains bashrc and bash_profile

## tmux/
tmux config file

## vim/
contains vimrc

