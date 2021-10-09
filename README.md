# dotfiles
Set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based workflow as explained in this [article](https://erichammel.xyz/posts/going-terminal-based/) on my blog.

## Pre-req
1. Run commands ton install zsh, oh-my-zsh, and set shell to zsh:
    ```bash
    sudo apt update && sudo apt upgrade -y \
        && sudo apt install zsh \
        && chsh -s $(which zsh)
    ```

2. Run `install.sh` will install the packages, cli tools, and create links for the different dotfiles

## Bash
Contains `.zshrc` and `.zprofile`

## tmux
tmux config files

## vim
contains `.vimrc` and an install script for plugins from GitHub.
