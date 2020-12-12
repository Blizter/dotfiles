#! /bin/bash

set -exo pipefail

#update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## adding repos for YARN

# Yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# Spotify repo
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update

# install the base
sudo apt install -y build-essentials make wget curl vim git tmux autojump universal-ctags\
    gnome-tweaks spotify-client yarn parallel llvm

# install pyenv requirements
if [ ! -d "/home/eric/.pyenv" ];
then
    sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev \
        libffi-dev liblzma-dev python-openssl &&\
        curl https://pyenv.run | bash
fi

wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz -P ~/Downloads/ &&\
    sudo tar -C /usr/local -xzf ~/Downloads/go1.15.6.linux-amd64.tar.gz

source ~/.bash_profile

sudo apt install -y python3-dev python3-pip

python3 -m pip install bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ~/.vim/ && mkdir -p ~/.vim/pack/{interface,colors,vc,md,nav,md}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh

echo "The system is yours to use, The world is within finger tips grasp!" && exit 0;
