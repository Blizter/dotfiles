#! /bin/bash 

## creating vim plugins folders
rm -rf ~/.vim/pack/
mkdir -p ~/.vim/{colors,pack/plugins/start}

## prallilize plugins repo cloning
parallel -a plugins.sh
