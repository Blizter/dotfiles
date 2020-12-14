# dotfiles
Set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based wrkflow as explained in this [article](https://erichammel.xyz/posts/going-terminal-based/) on my blog.

## Pre-req

install [inconsolata](https://levien.com/type/myfonts/inconsolata.html) font

`install.sh` will install packages, once done install oh-my-bash this way:
```bash
export OSH="$HOME/.dotfiles/oh-my-bash" &&\
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
```

create symlinks for the different dotfiles :
```bash
rm ~/.profile
rm ~/.bashrc
rm ~/.tmux.conf
rm ~/.vimrc
ln -sfv ~/Projects/dotfiles/bash/.profile ~
ln -sfv ~/Projects/dotfiles/bash/.bashrc ~
ln -sfv ~/Projects/dotfiles/tmux/.tmux.conf ~
ln -sfv ~/Projects/dotfiles/vim/.vimrc ~
```

## Bash
Contains `.bashrc` and and `.profile`

## tmux/
tmux config file

## vim/
contains `.vimrc` and a script that pulls plugins from github.
