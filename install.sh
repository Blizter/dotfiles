#! /bin/zsh
set -euo pipefail

brew update && \
brew install git wget curl tmux autojump parallel fzf \
    neovim ctags stow yarn node make kubectl tfenv \
    hadolint helm kind tree autojump golang && \
brew upgrade

source ${HOME}/.zprofile

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-darwin-arm64 && \
    chmod +x ./kind && mv ./kind  ${HOME}/.local/bin/kind
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

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
[ ! -d "${HOME}/.oh-my-zsh/completion" ] && mkdir -p ${HOME}/.oh-my-zsh/completions && \
    chmod -R 755 ${HOME}/.oh-my-zsh/completions && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
        -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
        -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh &&

# AWS cli version 2 Install
[ ! -f "/usr/local/bin/aws" ] && curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" && \
    sudo installer -pkg AWSCLIV2.pkg -target / && \
    rm AWSCLIV2.pkg

stow --restow --target=${HOME} dotfiles
source ${HOME}/.zprofile


echo "Done"
