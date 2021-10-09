## Vim plugins cloning

# interface
git clone --depth=1 git@github.com:vim-airline/vim-airline.git ~/.vim/pack/plugins/start/airline
git clone --depth=1 git@github.com:vim-airline/vim-airline-themes.git ~/.vim/pack/plugins/start/airline-themes

# colors
git clone --depth=1 git@github.com:axvr/photon.vim.git ~/.vim/pack/colors/start/photon
git clone --depth=1 git@github.com:sheerun/vim-polyglot.git ~/.vim/pack/colors/start/vim-polyglot

# Version control management
git clone --depth=1 git@github.com:tpope/vim-fugitive.git ~/.vim/pack/plugins/start/vim-fugitive
git clone --depth=1 git@github.com:airblade/vim-gitgutter.git ~/.vim/pack/plugins/start/vim-gitgutter

# Markdown preview
git clone --depth=1 git@github.com:plasticboy/vim-markdown.git ~/.vim/pack/plugins/start/vim-markdown
git clone --depth=1 git@github.com:iamcco/markdown-preview.nvim.git ~/.vim/pack/plugins/start/markdown-preview && cd ~/.vim/pack/plugins/start/markdown-preview && yarn install > /dev/null && cd ~

#Navigation
git clone --depth=1 git@github.com:tpope/vim-vinegar.git ~/.vim/pack/plugins/start/vim-vinegar
git clone --depth=1 git@github.com:preservim/tagbar.git ~/.vim/pack/plugins/start/tagbar

# IDE-like features (linting) with 
git clone --depth 1 git@github.com:dense-analysis/ale.git ~/.vim/pack/plugins/start/ale
git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1 ~/.vim/pack/plugins/start/coc.nvim

# Helptags generation
vim -u NONE -c 'helpztags ~/.vim/pack/plugins/start/vim-fugitive' '+q!' > /dev/null
vim -u NONE -c 'helpztags ~/.vim/pack/plugins/start/vim-gitgutter' '+q!' > /dev/null
vim -u NONE -c 'helpztags ~/.vim/pack/plugins/start/ale' -c 'q!' '+q!' > /dev/null
