#! /bin/zsh
set -euo pipefail

# Function download latest release from github api
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

github_latest_dl(){
    curl https://api.github.com/repos/$1/releases/latest \
        | grep -i "browser_download_url$2" | grep $3 | cut -d '"' -f 4 \
        | wget -i - -O $4
}

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
                    universal-ctags timewarrior stow flatpak \
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
        curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -; \
    mkdir -p $ZSH_CUSTOM/plugins/poetry/ ;\
    poetry completions zsh >| $ZSH_CUSTOM/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true || poetry self update 1.1.3

# Install go and go shell completion
sudo rm -rf /usr/local/go \
&& wget https://go.dev/dl/go1.17.6.linux-amd64.tar.gz  -O - | sudo tar -C /usr/local -xzf -

# [ $(which gocomplete) != "${HOME}/go/bin/gocomplete" ] && go install github.com/posener/complete@latest

# TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" ${HOME}/.zshrc)
# [ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && gocomplete -install -y


github_latest_dl hadolint/hadolint ".*x86_64" "Linux" /usr/local/bin/hadolint \
    && sudo chmod +x /usr/local/bin/hadolint

github_latest_dl app-outlet/app-outlet ".*deb" "amd64" ${HOME}/Downloads/app-outlet_2.0.2_amd64.deb \
    && sudo dpkg -i ${HOME}/Downloads/app-outlet_2.0.2_amd64.deb \
    && rm -f ${HOME}/Downloads/app-outlet_2.0.2_amd64.deb

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
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# install
sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt upgrade -y \
    && sudo apt-get -y install podman kubectl terraform azure-cli

# Download Kubectx
[ ! -f "${HOME}/.local/bin/kubectx" ] && \
    github_latest_dl ahmetb/kubectx "" "/kubectx\"" ${HOME}/.local/bin/kubectx \
    && chmod +x ${HOME}/.local/bin/kubectx
# Download Kubens
[ ! -f "${HOME}/.local/bin/kubens" ] && \
    github_latest_dl ahmetb/kubectx "" "/kubens$\"" ${HOME}/.local/bin/kubens \
    && chmod +x ${HOME}/.local/bin/kubens

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
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "${HOME}/Downloads/awscliv2.zip" \
    && unzip ${HOME}/Downloads/awscliv2.zip -d ${HOME}/Downloads/ \
    && sudo ${HOME}/Downloads/aws/install \
    && rm -rf ${HOME}/Downloads/awscliv2.zip ${HOME}/Downloads/aws

# # Install KinD
# curl -Lo ${HOME}/.local/bin/kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 \
#     && chmod +x ${HOME}/.local/bin/kind \
#     && ${HOME}/.local/bin/kind completion zsh >| ${HOME}/.oh-my-zsh/completions/_kind \
#     && chmod +x ${HOME}/.oh-my-zsh/completions/_kind

# Install Nord color theme
## GTK
[ ! -d "/usr/share/themes/Nordic-darker" ] && \
    sudo mkdir -p /usr/share/themes \
    && github_latest_dl EliverLara/Nordic "" "darker.tar.xz" ${HOME}/Downloads \
    && sudo tar -xf ${HOME}/Downloads/Nordic-darker.tar.xz -C /usr/share/themes \
    && rm -rf ${HOME}/Downloads/Nordic-darker.tar.xz \
    && gsettings set org.gnome.desktop.interface gtk-theme "Nordic-darker" \
    && gsettings set org.gnome.desktop.wm.preferences theme "Nordic-darker"

[ ! -d "${HOME}/nord-gnome-terminal" ] && \
    git clone https://github.com/arcticicestudio/nord-gnome-terminal.git ${HOME} \
    && source nord-gnome-terminal/src/nord.sh

stow --target=${HOME} dotfiles

echo "Done"
