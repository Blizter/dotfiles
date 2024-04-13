#! /bin/zsh
set -euo pipefail

# Function download latest release from github api
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

# Update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## Adding repos

mkdir -p ${HOME}/.local/{pyenv/bin,poetry/bin,go,bin,aws-cli/v2}
# Install base packages
sudo apt update && \
sudo apt install -y --fix-broken git wget curl tmux autojump parallel \
                    apt-transport-https ca-certificates \
                    gnupg fzf stow flatpak software-properties-common \
                    build-essential g++ gcc llvm make \
                    libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
                    libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k


# Install pyenv requirements
[ ! -d "${HOME}/.local/pyenv" ] &&
                                sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                    libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                                    libffi-dev liblzma-dev python-openssl && \
                                curl https://pyenv.run | bash &&\
                                mv ${HOME}/.pyenv/* ${HOME}/.local/pyenv/ \
                                || pyenv update

# install poetry
[ ! -d "${HOME}/.local/poetry" ] && \
    rm -rf "${HOME}/.local/poetry/*" && \
    sudo apt install -y python3-dev python3-pip && \
    python3 -m pip install --upgrade pip && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py |  \
        POETRY_HOME="${HOME}/.local/poetry" python3 python3 - && \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ && poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry && \
    poetry config virtualenvs.in-project true || poetry self update

# Install go and go shell completion
wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz  -O - | sudo tar -C ${HOME}/.local/go -xzf -

wget -O ${HOME}/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Darwin-x86_64 \
    && sudo chmod +x ${HOME}/.local/bin/hadolint

#install tfenv
git clone --depth=1 https://github.com/tfutils/tfenv.git ${HOME}/.local/tfenv && \
    ln -s ${HOME}/.local/tfenv/bin ${HOME}/.local/bin

# install azure CLI
# Microsoft signing keys
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt upgrade -y \
    && sudo apt-get -y install azure-cli && az config set auto-upgrade.enable=yes

# AWS cli version 2 Install
[ -d "${HOME}/.local/aws-cli/" ] && \
    wget -O ${HOME}/Downloads/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip ${HOME}/Downloads/awscliv2.zip -d ${HOME}/Downloads/ \
    && sudo ${HOME}/Downloads/aws/install --bin-dir "${HOME}/.local/bin" --install-dir "${HOME}/.local/aws-cli/ --update" \
    && rm -rf ${HOME}/Downloads/awscliv2.zip ${HOME}/Downloads/aws

# # Download Kubectx
# [ ! -f "${HOME}/.local/bin/kubectx" ] && \
#     curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
#         | grep -i "browser_download_url" | grep "/kubectx\"" | cut -d '"' -f 4 \
#         | wget -i - -O ${HOME}/.local/bin/kubectx \
#     && chmod +x ~/.local/bin/kubectx
# # Download Kubens
# [ ! -f "${HOME}/.local/bin/kubens" ] && \
#     curl https://api.github.com/repos/ahmetb/kubectx/releases/latest \
#         | grep -i "browser_download_url" | grep "/kubens\"" | cut -d '"' -f 4 \
#         | wget -i - -O ${HOME}/.local/bin/kubens \
#     && chmod +x ~/.local/bin/kubens
# # Kubens and kubectx zsh completion
# [ ! -d "${HOME}/.oh-my-zsh/completion" ] && \
#     mkdir -p ${HOME}/.oh-my-zsh/completions && \
#     chmod -R 755 ${HOME}/.oh-my-zsh/completions && \
#     wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
#         -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh && \
#     wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
#         -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh

# stow --restow --target=${HOME} dotfiles

# echo "Done"
