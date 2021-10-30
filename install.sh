#! /bin/zsh
set -euo pipefail

#update the system
sudo dnf update

## additional package repositories
# rpm fusion non-free and free
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## install the different tools

sudo dnf groupinstall -y "Development Tools" "Development Libraries"

sudo dnf install -y wget curl neovim tree mlocate git tmux autojump-zsh make ctags gnome-tweak-tool \
                    parallel llvm fedora-workstation-repositories powerline-fonts freeglut-devel \
                    libX11-devel libXi-devel libXmu-devel mesa-libGLU-devel podman

sudo npm install yarn -g \
    && sudo updatedb \
    && sudo dnf config-manager --set-enabled google-chrome \
    && sudo dnf install -y google-chrome-stable

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
            -P ${HOME}/Downloads/ -O - | sudo tar -C /usr/local -xzf -

go install github.com/posener/complete/gocomplete@latest

TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" $(pwd)/zsh/.zshrc)
[ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && \
    gocomplete -install -y

sudo dnf install -y python3-devel.x86_64 python3-pip
python3 -m pip install --upgrade bpytop pip; \

# install poetry
[ ! -d ${HOME}/.poetry ] &&
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --version 1.1.3; \
    mkdir -p ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/; \
    touch ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry; \
    ${HOME}/.poetry/bin/poetry completions zsh > ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/poetry/_poetry ; \
    poetry config virtualenvs.in-project true || ${HOME}/.poetry/bin/poetry self update 1.1.3

sudo wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 \
        -P ${HOME}/Downloads/ -O /usr/local/bin/hadolint \
    && sudo chmod +x /usr/local/bin/hadolint

ln -sfv ${HOME}/Projects/dotfiles/zsh/.zprofile ${HOME} \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.zshrc ${HOME} \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.p10k.zsh ${HOME} \
    && ln -sfv ${HOME}/Projects/dotfiles/tmux/.tmux.conf ${HOME} \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/init.vim \
            ${HOME}/.config/nvim/init.vim \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/.vimrc ${HOME}

echo "Done"
