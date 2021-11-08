#! /bin/zsh
set -euo pipefail

github_latest_dl(){
    curl https://api.github.com/repos/$1/releases/latest \
        | grep -i "browser_download_url$2" | grep $3 | cut -d '"' -f 4 \
        | wget -i - -O $4
}

#update the system
sudo dnf update -y

## additional package repositories
# rpm fusion non-free and free
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## install the different tools
sudo dnf groupinstall -y "Development Tools" "Development Libraries" \
&& sudo dnf install -y git-core wget curl tmux autojump-zsh parallel \
                    ca-certificates gnupg fzf neovim ctags tree\
                    vlc stacer podman timew stow go \
                    fedora-workstation-repositories dnf-plugins-core \
                    freeglut-devel libX11-devel libXi-devel libXmu-devel \
                    mesa-libGLU-devel \
&& sudo npm install yarn -g \
&& sudo updatedb \
&& go install github.com/posener/complete/gocomplete@latest

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

TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" $(pwd)/dotfiles/.zshrc)
[ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && ${HOME}/go/bin/gocomplete -install -y

sudo dnf install -y python3-devel.x86_64 python3-pip && python3 -m pip install --upgrade bpytop pip

# poetry
[ ! -d ${HOME}/.poetry ] &&
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - ; \
	mkdir -p ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/ ; \
    	touch ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry ; \
    #${HOME}/.poetry/bin/poetry completions zsh > ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry ; \
    #${HOME}/.poetry/bin/poetry config virtualenvs.in-project true 

mkdir -p ${HOME}/.local/bin

# Kubectl signing keys
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 755 kubectl && mv kubectl ${HOME}/.local/bin

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

[ ! -f "${HOME}/.local/bin/hadolint" ] && \
github_latest_dl hadolint/hadolint ".*x86_64" "Linux" ${HOME}/.local/bin/hadolint \
    && chmod +x ${HOME}/.local/bin/hadolint

[ ! -f "${HOME}/.local/bin/kubectx" ] && \
    github_latest_dl ahmetb/kubectx "" "kubectx$" ${HOME}/.local/bin/kubectx ; \
    chmod +x ${HOME}/.local/bin/kubectx
[ ! -f "${HOME}/.local/bin/kubens" ] && \
    github_latest_dl ahmetb/kubectx "" "kubens$" ${HOME}/.local/bin/kubectx ; \
    chmod +x ${HOME}/.local/bin/kubens

# Kubens and kubectx zsh completion
mkdir -p ${HOME}/.oh-my-zsh/completions && \
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
    -O ${HOME}/.oh-my-zsh/completions/_kubectx.zsh && \
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
    -O ${HOME}/.oh-my-zsh/completions/_kubens.zsh \
&& chmod -R 755 ${HOME}/.oh-my-zsh/completions

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

stow --target=${HOME} dotfiles

echo "Done"
