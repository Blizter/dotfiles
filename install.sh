#! /bin/zsh
set -euo pipefail

[ ! -d "${HOME}/.local/bin" ] && mkdir -p ${HOME}/.local/bin

# Update the system
sudo apt update && \
  sudo apt upgrade -y

# Install base packages
sudo apt install -y --fix-broken \
  git wget curl tmux parallel stow \
  flatpak software-properties-common \
  build-essential g++ gcc llvm make \
  tmux unzip snapd 

sudo snap install btop tree
sudo snap install nvim --classic

# Download Zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

[[ ! -f "${HOME}/.local/bin/zoxide" ]] && \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

[[ ! -d "${HOME}/.local/share/fzf" ]] && \
  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.local/share/fzf/ && \
  ${HOME}/.local/share/fzf/install

[ ! -f "${HOME}/.local/bin/uv" ] && curl -LsSf https://astral.sh/uv/install.sh | sh

#install tfenv
[ ! -d "${HOME}/local/share/.tfenv" ] && \
  git clone --depth=1 https://github.com/tfutils/tfenv.git ~/local/share/.tfenv

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

[ ! -f "${HOME}/.local/bin/sops" ] && \
  SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/getsops/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+') && \
  curl -LO https://github.com/getsops/sops/releases/download/v${SOPS_LATEST_VERSION}/sops-v${SOPS_LATEST_VERSION}.linux.amd64 &&
  mv sops-v${SOPS_LATEST_VERSION}.linux.amd64 ${HOME}/.local/bin/sops && chmod +x ${HOME}/.local/bin/sops 
[[ ! -f "${HOME}/.local/bin/kind" ]] && \
  wget -c https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64 -O ${HOME}/.local/bin/kind && \
  chmod +x ${HOME}/.local/bin/kind

#Kubens and kubectx zsh completion
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
  chmod +x kustomize && mv kustomize ~/.local/bin

stow -R -d ${HOME}/Projects/personal/dotfiles -t ${HOME} dotfiles

echo "Done"
