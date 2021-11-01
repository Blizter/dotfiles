#! /bin/zsh
set -euo pipefail

# Update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## Adding repos
# Yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Add nodejs repositories
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

# Install base packages
sudo apt update && sudo apt install -y build-essential make wget curl neovim \
        nodejs git tmux autojump universal-ctags gnome-tweaks yarn parallel llvm \
        g++ freeglut3-dev libx11-dev libxmu-dev libxi-dev libglu1-mesa \
        timewarrior libglu1-mesa-dev libfreeimage3 libfreeimage-dev \
        apt-transport-https ca-certificates gnupg software-properties-common

[ ! -d "${HOME}/.config/nvim" ] && mkdir -p "${HOME}/.config/nvim"

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install pyenv requirements
[ ! -d "${HOME}/.pyenv" ] && sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                                libffi-dev liblzma-dev python-openssl; \
                            curl https://pyenv.run | bash || pyenv update

# Install go and go shell completion
sudo rm -rf /usr/local/go \
    && wget https://golang.org/dl/go1.15.15.linux-amd64.tar.gz \
        -P ${HOME}/Downloads/ -O - | sudo tar -C /usr/local -xzf - \

[ $(which gocomplete) != "${HOME}/go/bin/gocomplete" ] && go install github.com/posener/complete@latest

TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" $(pwd)/zsh/.zshrc)
[ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && gocomplete -install -y

# install poetry
[ ! -d ${HOME}/.poetry ] && \
    sudo apt install -y python3-dev python3-pip; \
        python3 -m pip install --upgrade bpytop pip; \
        curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -; \
    poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true || poetry self update

wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 \
        -P ${HOME}/Downloads/ \
        -O /usr/local/bin/hadolint \
    && sudo chmod +x /usr/local/bin/hadolint

# PODMAN signing keys
source /etc/os-release
[ "$VERSION_ID" != "20.1*" ] && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list ;\
                                curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -

# Kubectl signing keys
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Terraform signing keys
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Microsoft sning keys
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ \
    $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# install
sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt upgrade -y \
    && sudo apt-get -y install podman kubectl terraform azure-cli

# AWS cli version 2 Install
[ ! -d "/usr/local/aws-cli/v2/" ] && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
        -o "${HOME}/Downloads/awscliv2.zip" \
    && unzip ${HOME}/Downloads/awscliv2.zip -d ${HOME}/Downloads/\
    && sudo ${HOME}/Downloads/aws/install \
    && rm -rf ${HOME}/Downloads/awscliv2.zip ${HOME}/Downloads/aws

# Install KinD
curl -Lo ${HOME}/.local/bin/kind \
    https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 \
    && chmod +x ${HOME}/.local/bin/kind

ln -sfv ${HOME}/Projects/dotfiles/zsh/.zprofile ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.zshrc ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.p10k.zsh ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/tmux/.tmux.conf ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/init.vim \
        ~/.config/nvim/init.vim \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/.vimrc ~

echo "Done"
