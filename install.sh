#! /bin/bash

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
sudo apt install -y build-essential make wget curl vim-gtk3 git tmux autojump universal-ctags\
    gnome-tweaks spotify-client yarn parallel llvm g++ freeglut3-dev build-essential libx11-dev \
    libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev libfreeimage3 libfreeimage-dev

# install pyenv requirements
if [ ! -d "${HOME}/.pyenv" ]; then
    echo "Installing pyenv"
    sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
        libffi-dev liblzma-dev python-openssl
    curl https://pyenv.run | bash
fi

wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz -P ${HOME}/Downloads/ &&\
    sudo tar -C /usr/local -xzf ${HOME}/Downloads/go1.15.6.linux-amd64.tar.gz &&\
    rm ${HOME}/Downloads/go1.15.6.linux-amd64.tar.gz

source ${HOME}/.profile

sudo apt install -y python3-dev python3-pip
python3 -m pip install --upgrade bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ${HOME}/.vim/ && mkdir -p ${HOME}/.vim/pack/{plugins,colors}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh

git clone https://github.com/powerline/fonts.git --depth=1 && source fonts/install.sh && fc-cache -vf && rm -rf fonts/

sudo apt autoclean autoremove

if [ ! -d "$HOME/.dotfiles/oh-my-bash"]; then
    export OSH="$HOME/.dotfiles/oh-my-bash"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

ln -sfv ~/Projects/dotfiles/bash/.profile ~
ln -sfv ~/Projects/dotfiles/bash/.bashrc ~
ln -sfv ~/Projects/dotfiles/tmux/.tmux.conf ~
ln -sfv ~/Projects/dotfiles/vim/.vimrc ~

echo "The system is yours to use, The world is within finger tips grasp!"
