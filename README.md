# dotfiles

## Pre-req
1. Install zsh, set shell to zsh, then reboot by executing the following block:
    ```bash
    sudo apt update && sudo apt upgrade -y \
        && sudo apt install zsh \
        && chsh -s $(which zsh) \
        && reboot
    ```
2. Install JetBrainsMono Nerde font
3. Run `install.sh` will install the packages, cli tools, and create links for the different dotfiles
