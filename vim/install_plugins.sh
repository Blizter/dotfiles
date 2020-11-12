#! /bin/bash 

## creating vim plugins folders
rm -rf ~/.vim/pack/
mkdir -p ~/.vim/pack/plugins/start

## clone plugins
git clone --depth=1 git@github.com:vim-airline/vim-airline.git ~/.vim/pack/plugins/start/airline
git clone --depth=1 git@github.com:vim-airline/vim-airline-themes.git ~/.vim/pack/plugins/start/airline-themes
