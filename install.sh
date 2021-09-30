#! /bin/zsh
set -xo pipefail

#update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## adding repos
# Yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# Spotify repo
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update

# install the base
sudo apt install -y zsh build-essential make wget curl vim-gtk3 git tmux autojump universal-ctags \
    gnome-tweaks spotify-client yarn parallel llvm g++ freeglut3-dev libx11-dev \
    libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev libfreeimage3 libfreeimage-dev

# install pyenv requirements
if [ ! -d "${HOME}/.pyenv" ]; then
    echo "Installing pyenv"
    sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
        libffi-dev liblzma-dev python-openssl
    curl https://pyenv.run | bash
fi

wget https://golang.org/dl/go1.17.linux-amd64.tar.gz -P ${HOME}/Downloads/ &&\
    sudo tar -C /usr/local -xzf ${HOME}/Downloads/go1.17.linux-amd64.tar.gz &&\
    rm ${HOME}/Downloads/go1.17.linux-amd64.tar.gz

source ${PWD}/zsh/.zprofile

go install gocomplete
gocomplete -install

sudo apt install -y python3-dev python3-pip
python3 -m pip install --upgrade bpytop pip

# installing vim plugins
## creating vim plugins folders
rm -rf ${HOME}/.vim/ && mkdir -p ${HOME}/.vim/pack/{plugins,colors}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh

git clone https://github.com/powerline/fonts.git --depth=1 && source fonts/install.sh && fc-cache -vf && rm -rf fonts/

sudo apt autoclean autoremove

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# PODMAN Install
. /etc/os-release
if [[ "$VERSION_ID" != "20.1*" ]]
then
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -
fi

sudo apt-get update && sudo apt upgrade -y
sudo apt-get -y install podman

wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -P ${HOME}/Downloads/ &&\
    sudo chmod +x ${HOME}/Downloads/hadolint-Linux-x86_64 &&\
    sudo mv ${HOME}/Downloads/hadolint-Linux-x86_64 /usr/local/bin/hadolint &&\

ln -sfv ~/Projects/dotfiles/zsh/.zprofile ~
ln -sfv ~/Projects/dotfiles/zsh/.zshrc ~
ln -sfv ~/Projects/dotfiles/tmux/.tmux.conf ~
ln -sfv ~/Projects/dotfiles/vim/.vimrc ~

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions


chsh -s $(which zsh)

echo "The system is yours to use, The world is within finger tips grasp!"
