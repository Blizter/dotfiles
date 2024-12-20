#! /bin/zsh
set -euo pipefail

brew update && \
brew install git wget curl tmux parallel fzf \
    neovim ctags stow yarn node make kubectl tfenv \
    hadolint helm kind tree golang zoxide && \

brew upgrade

source ${PWD}/dotfiles/.zshenv

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-darwin-arm64 && \
    chmod +x ./kind && mv ./kind  ${HOME}/.local/bin/kind

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

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

# AWS cli version 2 Install
[ ! -f "/usr/local/bin/aws" ] && curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" && \
    sudo installer -pkg AWSCLIV2.pkg -target / && \
    rm AWSCLIV2.pkg

stow --restow --target=${HOME} dotfiles

exec zsh

echo "Done"
