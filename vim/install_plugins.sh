#! /bin/bash 

## creating vim plugins folders
rm -rf ~/.vim/pack/
mkdir -p ~/.vim/{colors,pack/plugins/start}

## clone plugins
git clone --depth=1 git@github.com:vim-airline/vim-airline.git ~/.vim/pack/plugins/start/airline
git clone --depth=1 git@github.com:vim-airline/vim-airline-themes.git ~/.vim/pack/plugins/start/airline-themes
git clone --depth=1 git@github.com:ajmwagar/vim-deus.git ~/.vim/pack/plugins/start/vim-deus

