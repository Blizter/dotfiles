#! /bin/zsh
set -euo pipefail

# Function download latest release from github api
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

# Update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## Adding repos
# Yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Add nodejs repositories
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

# Install base packages
sudo apt update && \
sudo apt install -y --fix-broken git wget curl tmux autojump parallel \
                    apt-transport-https ca-certificates gnupg fzf neovim \
                    universal-ctags \
                    timewarrior stow flatpak \
                    software-properties-common build-essential \
                    g++ gcc llvm make yarn nodejs \
                    libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
                    libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions
[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

# Install pyenv requirements
[ ! -d "${HOME}/.pyenv" ] && sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                                libffi-dev liblzma-dev python-openssl && curl https://pyenv.run | bash \
                                || ${HOME}/.pyenv/bin/pyenv update

# install poetry
[ ! -d ${HOME}/.poetry ] && \
    sudo apt install -y python3-dev python3-pip; \
        python3 -m pip install --upgrade bpytop pip; \
        curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -; \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ ; \
    poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true

# Install go and go shell completion
sudo rm -rf /usr/local/go \
&& wget https://golang.org/dl/go1.17.6.linux-amd64.tar.gz  -O - | sudo tar -C /usr/local -xzf -

github_latest_dl hadolint/hadolint ".*x86_64" "Linux" /usr/local/bin/hadolint \
    && sudo chmod +x /usr/local/bin/hadolint

#install tfenv
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv

# Microsoft signing keys
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# install
sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt upgrade -y \
    && sudo apt-get -y install azure-cli

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
[ ! -d "/usr/local/aws-cli/v2/" ] && \
    wget -O ${HOME}/Downloads/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip ${HOME}/Downloads/awscliv2.zip -d ${HOME}/Downloads/ \
    && sudo ${HOME}/Downloads/aws/install \
    && rm -rf ${HOME}/Downloads/awscliv2.zip ${HOME}/Downloads/aws

stow --restow --target=${HOME} dotfiles

echo "Done"
