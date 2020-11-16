# dotfiles
set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based wrkflow as explained in this (article)[https://erichammel.xyz/posts/going-terminal-based/] on my blog.

## Pre-req
`install.sh` will install the packages I need, once done install oh-my-bash this way:
```bash
    export OSH="$HOME/.dotfiles/oh-my-bash"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
```

create symlinks for the different dotfiles :
```bash
    ln -sv ~/Projects/dotfiles/bash/.bash_profile ~
    ln -sv ~/Projects/dotfiles/bash/.bashrc ~
    ln -sv ~/Projects/dotfiles/tmux/.tmux.conf ~
    ln -sv ~/Projects/dotfiles/vim/.vimrc ~
```

## Bash
Contains `bashrc and` and `bash_profile`

## tmux/
tmux config file

## vim/
contains `.vimrc` and a script that pulls plugins from github.

