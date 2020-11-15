#! /bin/bash

#update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## install the different tools
sudo apt install curl wget git vim tmux autojump parallel gnome-tweaks fonts-powerline

## install python tools
sudo apt install python3-dev python3-pip
pip3 install bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ~/.vim/pack/
mkdir -p ~/.vim/{colors,pack/plugins/start}

## prallilize plugins repo cloning
parallel -a vim/plugins.sh

## installing other software or packges

#Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

