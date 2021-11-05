#! /bin/zsh
set -euo pipefail

#update the system
sudo dnf update -y

## additional package repositories
# rpm fusion non-free and free
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## install the different tools
sudo dnf groupinstall -y "Development Tools" "Development Libraries" \
&& sudo dnf install -y wget curl neovim tree mlocate git tmux autojump-zsh make ctags gnome-tweak-tool \
                    parallel llvm fedora-workstation-repositories powerline-fonts freeglut-devel \
                    libX11-devel libXi-devel libXmu-devel mesa-libGLU-devel podman timew stow stacer
                    dnf-plugins-core \
&& sudo npm install yarn -g \
&& sudo updatedb

[ ! -d "${HOME}/.config/nvim" ] && mkdir -p "${HOME}/.config/nvim"

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

[ ! -d "/home/eric/.pyenv" ] && \
    sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel \
        sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils; \
    curl https://pyenv.run | bash || ${HOME}/.pyenv/bin/pyenv update

sudo rm -rf /usr/local/go \
    && wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz \
            -P ${HOME}/Downloads/ -O - | sudo tar -C /usr/local -xzf - \
    && go install github.com/posener/complete/gocomplete@latest

TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" $(pwd)/.dotfiles/.zshrc)
[ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && \
    gocomplete -install -y

sudo dnf install -y python3-devel.x86_64 python3-pip && python3 -m pip install --upgrade bpytop pip

# poetry
[ ! -d ${HOME}/.poetry ] &&
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --version 1.1.3; \
   mkdir -p ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/ ; \
    touch ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry ; \
    ${HOME}/.poetry/bin/poetry completions zsh > ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true || ${HOME}/.poetry/bin/poetry self update 1.1.3

mkdir -p ${HOME}/.local/bin

# Kubectl signing keys
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 755 kubectl \
&& mv kubectl ${HOME}/.local/bin

# Terraform signing keys
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

# Microsoft signing keys
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo

#install kubectl terraform azure-cli
sudo dnf -y install terraform azure-cli

# hadolint dockerfile linter
sudo wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 \
        -P ${HOME}/Downloads/ -O ${HOME}/.local/bin/hadolint \
    && sudo chmod +x ${HOME}/.local/bin/hadolint

# Download Kubectx
[ ! -f "${HOME}/.local/bin/kubectx" ] && \
    wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx \
        -O ${HOME}/.local/bin/kubectx; \
    chmod +x ${HOME}/.local/bin/kubectx

# Download Kubens
[ ! -f "${HOME}/.local/bin/kubens" ] && \
    wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens \
        -O ${HOME}/.local/bin/kubens; \
    chmod +x ${HOME}/.local/bin/kubens

# Kubens and kubectx zsh completion
mkdir -p ${HOME}/.oh-my-zsh/completions; \
chmod -R 755 ${HOME}/.oh-my-zsh/completions; \
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
    -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh; \
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
    -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh; \

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
    && chmod +x ${HOME}/.local/bin/kind \
    && ${HOME}/.local/bin/kind completion zsh >| \
        ${HOME}/.oh-my-zsh/completions/_kind \
    && chmod +x ${HOME}/.oh-my-zsh/completions/_kind

stow .dotfiles

echo "Done"
