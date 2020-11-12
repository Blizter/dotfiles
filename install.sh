#! /bin/bash

#update the system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

## install the different tools
sudo apt install curl wget git vim tmux autojump fonts-powerline

## install python tools
sudo apt install python3-dev python3-pip
pip3 install bpytop

# installing vim plugins
source ./vim/install_plugins.sh
