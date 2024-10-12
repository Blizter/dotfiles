#! /bin/zsh
set -euo pipefail

# Update the system
sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt dist-upgrade

# Install base packages
sudo apt install -y --fix-broken git wget curl tmux autojump parallel \
                    apt-transport-https ca-certificates \
                    gnupg fzf stow flatpak software-properties-common \
                    build-essential g++ gcc llvm make \
                    libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
                    libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev golang-go

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

# install rye
[ ! -d "${HOME}/.rye" ] && \
    curl -sSf https://rye.astral.sh/get | bash

wget -O ${HOME}/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Darwin-x86_64 \
    && sudo chmod +x ${HOME}/.local/bin/hadolint

#install tfenv
rm -rf ${HOME}/.local/tfenv && \
    git clone --depth=1 https://github.com/tfutils/tfenv.git ${HOME}/.local/tfenv && \
    ls ${HOME}/.local/tfenv/bin/ | xargs -I '%' ln -fs ${HOME}/.local/tfenv/bin/% ${HOME}/.local/bin/%

# install azure CLI
# Microsoft signing keys
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt-get install -y azure-cli && az config set auto-upgrade.enable=yes

# AWS cli version 2 Install
[ -d "${HOME}/.local/aws-cli/" ] && \
    wget -O ${HOME}/Downloads/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip ${HOME}/Downloads/awscliv2.zip -d ${HOME}/Downloads/ \
    && sudo ${HOME}/Downloads/aws/install --update --bin-dir "${HOME}/.local/bin" --install-dir "${HOME}/.local/aws-cli/" \
    && rm -rf ${HOME}/Downloads/awscliv2.zip ${HOME}/Downloads/aws

# Download Kubectx
[ ! -f "${HOME}/.local/bin/kubectx" ] && \
    curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
        | grep -i "browser_download_url" | grep "/kubectx\"" | cut -d '"' -f 4 \
        | wget -i - -O ${HOME}/.local/bin/kubectx && \
        chmod +x ~/.local/bin/kubectx
# Download Kubens
[ ! -f "${HOME}/.local/bin/kubens" ] && \
    curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
        | grep -i "browser_download_url" | grep "/kubens\"" | cut -d '"' -f 4 \
        | wget -i - -O ${HOME}/.local/bin/kubens && \
        chmod +x ~/.local/bin/kubens

# Kubens and kubectx zsh completion
[ ! -d "${HOME}/.oh-my-zsh/completion" ] && \
    mkdir -p ${HOME}/.oh-my-zsh/completions && chmod -R 755 ${HOME}/.oh-my-zsh/completions && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh && \
    wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh

curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

curl --output localstack-cli-3.8.0-linux-amd64-onefile.tar.gz --location https://github.com/localstack/localstack-cli/releases/download/v3.8.0/localstack-cli-3.8.0-linux-amd64-onefile.tar.gz && \
    sudo tar xvzf localstack-cli-3.8.0-linux-*-onefile.tar.gz -C /usr/local/bin && \
    rm -f localstack-cli-3.8.0-linux-*-onefile.tar.gz

git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

stow --restow --target=${HOME} dotfiles
echo "Done"
