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

## install the different tools
sudo apt install -y curl wget git vim tmux yarn \
    autojump parallel universal-ctags gnome-tweaks fonts-powerline \
    spotify-client python3-dev python3-pip

pip3 install bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ~/.vim/ &&\
    mkdir -p ~/.vim/pack/{interface,colors,vc,md,nav,md}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh

