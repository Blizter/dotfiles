#! /bin/zsh
set -euo pipefail

[ ! -d "${HOME}/.local/bin" ] && mkdir -p ${HOME}/.local/bin
[ ! -d "${HOME}/.local/secrets" ] && mkdir -p ${HOME}/.local/secrets

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ARCH=$(uname -m)
NVIM_VERSION="v0.11.4"

sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf group install -y "Development Tools"

source ${PWD}/dotfiles/.zshenv

sudo dnf install -y https://rpmfind.net/linux/fedora/linux/releases/42/Everything/${ARCH}/os/Packages/s/stow-2.4.1-2.fc42.noarch.rpm
sudo dnf install -y git wget curl unzip

# Download Zinit, if it's not there yet
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

[ ! -f "${HOME}/.local/bin/nvim" ] && \
  wget -i "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${ARCH}.appimage" \
  -O ${HOME}/.local/bin/nvim && \
  chmod 711 ${HOME}/.local/bin/nvim

[[ ! -f "${HOME}/.local/bin/zoxide" ]] && \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

[[ ! -d "${HOME}/.local/share/fzf" ]] && \
  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.local/share/fzf/ && \
  ${HOME}/.local/share/fzf/install

if [ ! -f "$(which kubectl)" ]; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${ARCH}/kubectl"
  
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${ARCH}/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/kubectl
fi

stow -R -d ${HOME}/Projects/dotfiles -t ${HOME} dotfiles

source ${HOME}/.zshrc
echo "Done"
