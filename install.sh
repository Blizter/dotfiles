#! /bin/zsh
set -euo pipefail

[ ! -d "${HOME}/.local/bin" ] && mkdir -p ${HOME}/.local/bin

# Update the system
sudo apt update && \
  sudo apt upgrade -y && \
  sudo apt dist-upgrade && \
  sudo add-apt-repository universe

# Install base packages
sudo apt install -y --fix-broken \
  git wget curl tmux autojump parallel \
  apt-transport-https ca-certificates libfuse2t64 \
  gnupg stow flatpak software-properties-common \
  build-essential g++ gcc llvm make unzip \
  libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
  libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev

sudo snap install btop tree

#Install ppa
sudo add-apt-repository ppa:longsleep/golang-backports && \
sudo apt-get update && sudo apt-get install golang-go
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

[ ! -f "${HOME}/.local/bin/nvim" ] && \
  wget -i https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
    -O ${HOME}/.local/bin/nvim && \
  chmod +x ${HOME}/.local/bin/nvim

[[ ! -f "${HOME}/.local/bin/zellij" ]] &&  \
  curl https://api.github.com/repos/zellij-org/zellij/releases/latest | \
    grep -i "browser_download_url" | \
    grep -i "/zellij-x86_64-unknown-linux-musl.tar.gz" |  \
    cut -d '"' -f 4 | wget -i - -O- | \
    tar xvz -C $HOME/.local/bin

[[ ! -f "${HOME}/.local/bin/zoxide" ]] && \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

[[ ! -f "${HOME}/.local/bin/kind" ]] && \
  wget -c https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64 -O ${HOME}/.local/bin/kind && \
  chmod +x ${HOME}/.local/bin/kind

[[ ! -d "${HOME}/.local/share/fzf" ]] && \
  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.local/share/fzf/ && \
  ${HOME}/.local/share/fzf/install

[ ! -f "${HOME}/.local/bin/uv" ] && curl -LsSf https://astral.sh/uv/install.sh | sh

[ ! -f "${HOME}/.local/bin/hadolint" ] && \
    curl https://api.github.com/repos/hadolint/hadolint/releases/latest | \                                                                                                               ─╯
    grep -i "browser_download_url" | grep -i "/hadolint-Linux-x86_64\"$" |  \
    cut -d '"' -f 4 | wget -i - -O ${HOME}/.local/bin/hadolint && chmod +x ${HOME}/.local/bin/hadolint

#install tfenv
[ ! -f "${HOME}/.local/bin/tfenv" ] && \
  curl https://api.github.com/repos/hadolint/hadolint/releases/latest | \
    grep -i "browser_download_url" | \
    grep -i "/hadolint-Linux-x86_64" |  \
    cut -d '"' -f 4 | wget -i - -O -C $HOME/.local/bin

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
    wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O ${HOME}/awscliv2.zip && \
    unzip ${HOME}/awscliv2.zip -d ${HOME} && \
    sudo ${HOME}/aws/install --update --bin-dir "${HOME}/.local/bin" \
        --install-dir "${HOME}/.local/share/aws-cli/" && \
    rm -rf ${HOME}/aws* ${HOME}/aws

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

# Cilium CLI
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz ${HOME}/.local/bin/
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

#Flux CLI
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.5.0 bash

#Tanka
curl -Lo ${HOME}/.local/bin/tk https://github.com/grafana/tanka/releases/latest/download/tk-linux-amd64 && \
chmod 755 ${HOME}/.local/bin/tk

#Jsonnet
curl -Lo ${HOME}/.local/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/latest/download/jb-linux-amd64 && \
chmod 755 ${HOME}/.local/bin/jb

#Kubens and kubectx zsh completion
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash &&
  chmod +x kustomize && mv kustomize ~/.local/bin

# Cue Language & Timoni
go install cuelang.org/go/cmd/cue@latest
go install github.com/stefanprodan/timoni/cmd/timoni@latest

# wget $(curl https://api.github.com/repos/stefanprodan/timoni/releases/latest | \
#   jq -r '.assets[] | select(.browser_download_url | contains ("linux_arm64")) | .browser_download_url') -O ${HOME}/.local/bin/timoni && \
# chmod 744 ${HOME}/.local/bin/timoni

curl --output localstack-cli-3.8.0-linux-amd64-onefile.tar.gz \
    --location https://github.com/localstack/localstack-cli/releases/download/v3.8.0/localstack-cli-3.8.0-linux-amd64-onefile.tar.gz && \
  sudo tar xvzf localstack-cli-3.8.0-linux-*-onefile.tar.gz -C /usr/local/bin && \
  rm -f localstack-cli-3.8.0-linux-*-onefile.tar.gz

stow --restow --target=${HOME} dotfiles/

echo "Done"
