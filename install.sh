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
        libglu1-mesa-dev libfreeimage3 libfreeimage-dev

[ ! -d "${HOME}/.config/nvim" ] && mkdir -p "${HOME}/.config/nvim"
[ ! -d "${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] && git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions

# Install pyenv requirements
[ ! -d "${HOME}/.pyenv" ] && sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                                libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                                libffi-dev liblzma-dev python-openssl; \
                            curl https://pyenv.run | bash || pyenv update

# Install go and go shell completion
sudo rm -rf /usr/local/go \
    && wget https://golang.org/dl/go1.15.15.linux-amd64.tar.gz -P ${HOME}/Downloads/ -O - | sudo tar -C /usr/local -xzf - \

[ $(which gocomplete) != "${HOME}/go/bin/gocomplete" ] && go install github.com/posener/complete@latest

TEST_OUTPUT=$(grep -e "complete -o nospace -C /home/eric/go/bin/gocomplete go" $(pwd)/zsh/.zshrc)
[ ${TEST_OUTPUT} != "complete -o nospace -C /home/eric/go/bin/gocomplete go" ] && gocomplete -install -y

# install poetry
[ ! -d ${HOME}/.poetry ] && sudo apt install -y python3-dev python3-pip; \
                            python3 -m pip install --upgrade bpytop pip; \
                            curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -; \
                            poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry || poetry self update

git clone https://github.com/powerline/fonts.git --depth=1 \
    && source fonts/install.sh \
    && fc-cache -vf \
    && rm -rf fonts

wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 \
        -P ${HOME}/Downloads/ \
        -O /usr/local/bin/hadolint \
    && sudo chmod +x /usr/local/bin/hadolint

# PODMAN Install
source /etc/os-release
[ "$VERSION_ID" != "20.1*" ] && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list ;\
                                curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -

sudo apt autoclean autoremove \
    && sudo apt-get update \
    && sudo apt upgrade -y \
    && sudo apt-get -y install podman

ln -sfv ${HOME}/Projects/dotfiles/zsh/.zprofile ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.zshrc ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/tmux/.tmux.conf ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/init.vim ~/.config/nvim/init.vim \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/.vimrc ~

echo "Done"
