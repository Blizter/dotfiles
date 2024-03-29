# dotfiles
Set of dotfiles to configure my environments. This repo is part of my decision to go further with my terminal-based workflow as explained in this [article](https://erichammel.xyz/posts/going-terminal-based/) on my blog.

## Pre-req
1. Install zsh, set shell to zsh, then reboot by executing the following block:
    ```bash
    sudo apt update && sudo apt upgrade -y \
        && sudo apt install zsh \
        && chsh -s $(which zsh) \
        && reboot
    ```
2. [Install oh-my-sh](https://github.com/ohmyzsh/ohmyzsh#basic-installation):
 ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
3. [install Nerd Font Caskaydia](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip) and use it as the font for your

4. Run `install.sh` will install the packages, cli tools, and create links for the different dotfiles
