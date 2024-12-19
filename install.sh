#! /bin/zsh
set -euo pipefail

[ ! -d "${HOME}/.local/bin" ] && mkdir -p ${HOME}/.local/bin

# Update the system
sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt dist-upgrade && \
    sudo add-apt-repository universe

# Install base packages
sudo apt install -y --fix-broken git wget curl tmux autojump parallel \
                    apt-transport-https ca-certificates libfuse2t64 \
                    gnupg stow flatpak software-properties-common \
                    build-essential g++ gcc llvm make unzip \
                    libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
                    libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev golang-go

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

if [ ! -f "${HOME}/.local/bin/nvim" ]; then
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim
fi
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl -s https://ohmyposh.dev/install.sh | bash -s
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64 && chmod +x ./kind &&  mv kind ${HOME}/.local/bin/kind

git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_HOME && $FZF_HOME/install

[ ! -d "${HOME}/.local/bin/uv" ] && curl -LsSf https://astral.sh/uv/install.sh | sh

wget -O ${HOME}/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Darwin-x86_64 \
    && sudo chmod +x ${HOME}/.local/bin/hadolint

#install tfenv
rm -rf ${HOME}/.local/tfenv && \
    git clone --depth=1 https://github.com/tfutils/tfenv.git ${HOME}/.local/share/tfenv && \
    ls ${HOME}/.local/share/tfenv/bin/ | xargs -I '%' ln -fs ${HOME}/.local/share/tfenv/bin/% ${HOME}/.local/bin/%

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

# Download Kubens
[ ! -f "${HOME}/.local/bin/fzf" ] && \
    curl https://api.github.com/repos/junegunn/fzf/releases/latest \
        | grep -i "browser_download_url" | grep "/fzf\"" | cut -d '"' -f 4 \
        | wget -i - -O ${HOME}/.local/bin/fzf && \
        chmod +x ~/.local/bin/fzf

# Kubens and kubectx zsh completion
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash &&
    chmod +x kustomize && mv kustomize ~/.local/bin

curl --output localstack-cli-3.8.0-linux-amd64-onefile.tar.gz --location https://github.com/localstack/localstack-cli/releases/download/v3.8.0/localstack-cli-3.8.0-linux-amd64-onefile.tar.gz && \
    sudo tar xvzf localstack-cli-3.8.0-linux-*-onefile.tar.gz -C /usr/local/bin && \
    rm -f localstack-cli-3.8.0-linux-*-onefile.tar.gz

stow --restow --target=${HOME} dotfiles/

echo "Done"
