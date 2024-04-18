#! /bin/zsh
set -euo pipefail

stow --restow --target=${HOME} dotfiles

brew update && \
brew install git wget curl tmux autojump parallel fzf \
    neovim ctags stow yarn node make pyenv pyenv-virtualenv \
    kubectl tfenv hadolint helm podman-desktop kind \
    saml2aws tree 

<<<<<<< HEAD
source ${HOME}/.zprofile

## install python version
pyenv install 3.11.4
pyenv global 3.11.4
pyenv rehash

# install poetry
[ ! -d ${HOME}/.poetry ] && \
    curl -sSL https://install.python-poetry.org | python3 -; \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ ; \
    poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true
=======
# Install base packages
sudo apt install -y --fix-broken git wget curl tmux autojump parallel \
                    apt-transport-https ca-certificates \
                    gnupg fzf stow flatpak software-properties-common \
                    build-essential g++ gcc llvm make \
                    libglu1-mesa libfreeimage3 libxi-dev libx11-dev \
                    libxmu-dev freeglut3-dev libglu1-mesa-dev libfreeimage-dev
>>>>>>> fa96536dd0775b9f32c0cc6370041400060efed5

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && mv nvim.appimage ${HOME}/.local/bin/nvim

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

<<<<<<< HEAD
=======
# Install pyenv requirements
[ ! -d "${HOME}/.pyenv/" ] && sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                    libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                                    libffi-dev liblzma-dev python-openssl && \
                                curl https://pyenv.run | bash || ${HOME}/.pyenv/bin/pyenv update

# install poetry
[ ! -d "${HOME}/.poetry" ] && \
    sudo apt install -y python3-dev python3-pip && \
    python3 -m pip install --upgrade pip && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ && poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry && \
    poetry config virtualenvs.in-project true || poetry self update

# Install go and go shell completion
wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz  -O - | sudo tar -C ${HOME}/.local/ -xzf -

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

>>>>>>> fa96536dd0775b9f32c0cc6370041400060efed5
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
<<<<<<< HEAD
        -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh && \

# AWS cli version 2 Install
[ ! -f "/usr/local/bin/aws" ] && \
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" \
    && sudo installer -pkg AWSCLIV2.pkg -target / \
    && rm AWSCLIV2.pkg
    
source ${HOME}/.zprofile

=======
        -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh

stow --restow --target=${HOME} dotfiles
>>>>>>> fa96536dd0775b9f32c0cc6370041400060efed5
echo "Done"
