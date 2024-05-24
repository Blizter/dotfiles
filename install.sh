#! /bin/zsh
set -euo pipefail

stow --restow --target=${HOME} dotfiles

brew update && \
brew install git wget curl tmux autojump parallel fzf \
    neovim ctags stow yarn node make pyenv pyenv-virtualenv \
    kubectl tfenv hadolint helm podman-desktop kind \
    saml2aws tree 

source ${HOME}/.zprofile

## install python version
pyenv install 3.11.4
pyenv global 3.11.4
pyenv rehash

# install poetry
[ ! -d ${HOME}/.poetry ] && \
    curl -sSL https://install.python-poetry.org | python3 -; \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ ; \
    poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

# Download Kubectx
[ ! -f "${HOME}/.local/bin/kubectx" ] && \
    curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
        | grep -i "browser_download_url" | grep "/kubectx\"" | cut -d '"' -f 4 \
        | wget -i - -O ${HOME}/.local/bin/kubectx \
    && chmod +x ~/.local/bin/kubectx
# Download Kubens
[ ! -f "${HOME}/.local/bin/kubens" ] && \
    curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
        | grep -i "browser_download_url" | grep "/kubens\"" | cut -d '"' -f 4 \
        | wget -i - -O ${HOME}/.local/bin/kubens \
    && chmod +x ~/.local/bin/kubens
# Kubens and kubectx zsh completion
[ ! -d "${HOME}/.oh-my-zsh/completion" ] && \
    mkdir -p ${HOME}/.oh-my-zsh/completions && \
    chmod -R 755 ${HOME}/.oh-my-zsh/completions && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
        -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
        -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh && \

# AWS cli version 2 Install
[ ! -f "/usr/local/bin/aws" ] && \
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" \
    && sudo installer -pkg AWSCLIV2.pkg -target / \
    && rm AWSCLIV2.pkg
    
source ${HOME}/.zprofile

echo "Done"
