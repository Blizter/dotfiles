#! /bin/bash

set -exo pipefail

#update the system
sudo dnf update

## additional package repositories
# rpm fusion non-free and free
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo


## install the different tools
sudo dnf module install -y nodejs:12
sudo dnf install -y lpf-spotify-client wget curl tmux vim autojump parallel gnome-tweak-tool tree mlocate

sudo updatedb

# pyenv requirements
sudo dnf groupinstall -y 'Development Tools'
sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite \
    sqlite-devel openssl-devel xz xz-devel libffi-devel findutils

[ ! -d "/home/eric/.pyenv" ] || curl https://pyenv.run | bash

wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz -P ~/Downloads/ &&\
    sudo tar -C /usr/local -xzf ~/Downloads/go1.15.6.linux-amd64.tar.gz

source ~/.bashrc

sudo dnf install -y python3-devel.x86_64 python3-pip python3-wheel
python3 -m pip install bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ~/.vim/ &&\
    mkdir -p ~/.vim/pack/{interface,colors,vc,md,nav,md}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh
echo "The system is yours to use, The world is within finger tips grasp!" 
