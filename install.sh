#! /bin/zsh
set -euo pipefail

# brew update && \
# brew install git wget curl tmux parallel fzf podman \
#     opencode stow make kubectl tfenv font-caskaydia-mono-nerd-font \
#     hadolint helm kind tree golang zoxide fluxcd/tap/flux neovim maccy && \
# brew upgrade

# brew install --cask betterdisplay

source ${PWD}/dotfiles/.zshenv

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
wget -qO- https://astral.sh/uv/install.sh | sh
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
chmod +x kustomize && mv kustomize ${HOME}/.local/bin/kustomize && 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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

exec zsh && \
  stow --restow --target=${HOME} \
    "${HOME}/Projects/personal/dotfiles/dotfiles/dotfiles"

echo "Done"
