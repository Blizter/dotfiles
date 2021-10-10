#! /bin/zsh
set -o pipefail errexit nounset

#update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## adding repos
# Yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# install the base
sudo apt update && sudo apt install -y build-essential make wget curl neovim\
    git tmux autojump universal-ctags gnome-tweaks yarn parallel llvm g++ nodejs \
    freeglut3-dev libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev \
    libfreeimage3 libfreeimage-dev

[ ! -d ${HOME}/.config/nvim ] && mkdir -p ${HOME}/.config/nvim
[ ! -d ${ZSH_CUSTOM}/plugins/zsh-completions ] git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# install pyenv requirements
if [ ! -d "${HOME}/.pyenv" ]; then
    echo "Installing pyenv"
    sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
        libffi-dev liblzma-dev python-openssl
    curl https://pyenv.run | bash
fi

# install poetry
sudo apt install -y python3-dev python3-pip \
    && python3 -m pip install --upgrade bpytop pip \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - \
    && poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

#install go and go shell completion
sudo rm -rf /usr/local/go
wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz -P ${HOME}/Downloads/ --output - | sudo tar -C /usr/local -xzf ${HOME}/Downloads/go1.17.1.linux-amd64.tar.gz \
    && go install

source ${PWD}/zsh/.zprofile

go install github.com/posener/complete@latest && gocomplete -install < "yes"

# installing vim plugins
## creating vim plugins folders
rm -rf ${HOME}/.vim/ && mkdir -p ${HOME}/.vim/pack/{plugins,colors}/start

git clone https://github.com/powerline/fonts.git --depth=1 \
    && source fonts/install.sh && fc-cache -vf && rm -rf fonts/

sudo apt autoclean autoremove

# PODMAN Install
. /etc/os-release
if [[ "$VERSION_ID" != "20.1*" ]]
then
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -
fi

sudo apt-get update && sudo apt upgrade -y && sudo apt-get -y install podman

wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -P ${HOME}/Downloads/ \
    && sudo chmod +x ${HOME}/Downloads/hadolint-Linux-x86_64 \
    && sudo mv ${HOME}/Downloads/hadolint-Linux-x86_64 /usr/local/bin/hadolint

ln -sfv ${HOME}/Projects/dotfiles/zsh/.zprofile ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/zsh/.zshrc ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/tmux/.tmux.conf ~ \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/init.vim ~/.config/nvim \
    && ln -sfv ${HOME}/Projects/dotfiles/nvim/.vimrc ~

echo "The system is yours to use, The world is within finger tips grasp!"
