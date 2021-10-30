# dotfiles
Set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based workflow as explained in this [article](https://erichammel.xyz/posts/going-terminal-based/) on my blog.

## Pre-req
1. Run commands ton install zsh, oh-my-zsh, and set shell to zsh:
    ```bash
    sudo apt update && sudo apt upgrade -y \
        && sudo apt install zsh \
        && chsh -s $(which zsh)
    ```

2. [Install oh-my-sh](https://github.com/ohmyzsh/ohmyzsh#basic-installation):
 ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

3. Run `install.sh` will install the packages, cli tools, and create links for the different dotfiles
4. [install Nerd Font Caskaydia](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip)

## Zsh
Contains :
- `.zshrc`
- `.zprofile`
- `.p10k.zsh`
- `.inputrc`

## tmux
- `.tmux.conf`

## Neovim
- `init.vim`
- `.vimrc`
