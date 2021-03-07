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
sudo dnf install -y lpf-spotify-client wget curl tmux vim autojump parallel gnome-tweak-tool tree mlocate fedora-workstation-repositories powerline-fonts freeglut-devel libX11-devel libXi-devel libXmu-devel make mesa-libGLU-devel
 

# enable third-party
sudo dnf config-manager --set-enabled google-chrome

# install third party
sudo dnf install -y google-chrome-stable

sudo updatedb

# pyenv requirements
sudo dnf groupinstall -y 'Development Tools'

if [ ! -d "/home/eric/.pyenv" ];
then
    sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite \
    sqlite-devel openssl-devel xz xz-devel libffi-devel findutils
    curl https://pyenv.run | bash
fi
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz -P ${HOME}/Downloads/ &&\
    sudo tar -C /usr/local -xzf ${HOME}/Downloads/go1.15.6.linux-amd64.tar.gz &&\
    rm ${HOME}/Downloads/go1.15.6.linux-amd64.tar.gz

source ${HOME}/.bash_profile

sudo dnf install -y python3-devel.x86_64 python3-pip python3-wheel
python3 -m pip install bpytop

# installing vim plugins
## creating vim plugins folders
rm -rf ${HOME}/.vim/ && mkdir -pv ${HOME}/.vim/pack/{plugins,colors}/start

## vim plugins repo cloning as a parallel process
parallel -a ./vim/plugins.sh

# powerline fonts 
git clone https://github.com/powerline/fonts.git --depth=1 && source fonts/install.sh &&\
    fc-cache -vf && rm -rf fonts/

printf "The system is yours to use, The world is within finger tips grasp!" 
