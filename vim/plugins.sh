#! /bin/bash

set -exo pipefail

## Vim plugins cloning
# interface
git clone --depth=1 git@github.com:vim-airline/vim-airline.git ~/.vim/pack/interface/start/airline
git clone --depth=1 git@github.com:vim-airline/vim-airline-themes.git ~/.vim/pack/interface/start/airline-themes
# colors

git clone --depth=1 git@github.com:axvr/photon.vim.git ~/.vim/pack/colors/start/photon
#git clone --depth=1 git@github.com:ajmwagar/vim-deus.git ~/.vim/pack/colors/start/vim-deus
git clone --depth=1 git@github.com:sheerun/vim-polyglot.git ~/.vim/pack/colors/start/vim-polyglot
# Version control management
git clone --depth=1 git@github.com:tpope/vim-fugitive.git ~/.vim/pack/vc/start/vim-fugitive
git clone --depth=1 git@github.com:airblade/vim-gitgutter.git ~/.vim/pack/vc/start/vim-gitgutter
# Markdown preview
git clone --depth=1 git@github.com:plasticboy/vim-markdown.git ~/.vim/pack/md/start/vim-markdown
git clone --depth=1 git@github.com:iamcco/markdown-preview.nvim.git ~/.vim/pack/md/start/markdown-preview && cd ~/.vim/pack/md/start/markdown-preview && yarn install > /dev/null && cd ~
#Navigation
git clone --depth=1 git@github.com:tpope/vim-vinegar.git ~/.vim/pack/nav/start/vim-vinegar
git clone --depth=1 git@github.com:preservim/tagbar.git ~/.vim/pack/nav/start/tagbar
# IDE-like features (linting)
git clone --depth 1 git@github.com:dense-analysis/ale.git ~/.vim/pack/ide/start/ale

## Helptags generation
vim -u NONE -c 'helpztags ~/.vim/pack/vc/start/vim-fugitive' '+q!' > /dev/null
vim -u NONE -c 'helpztags ~/.vim/pack/vc/start/vim-gitgutter' '+q!' > /dev/null
vim -u NONE -c 'helpztags ~/.vim/pack/ide/start/ale' -c 'q!' '+q!' > /dev/null
