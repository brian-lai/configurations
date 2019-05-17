#! /bin/bash
# Script to download vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# download via git
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/rstacruz/sparkup.git ~/.vim/bundle/sparkup
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab
git clone https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
git clone https://github.com/tpope/vim-commentary.git ~/.vim/bundle/vim-commentary
git clone https://github.com/kristijanhusak/vim-hybrid-material ~/.vim/bundle/vim-hybrid-material
git clone https://github.com/sheerun/vim-polyglot.git ~/.vim/bundle/vim-polyglot
git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible

# install git completion
brew install git bash-completion

# special steps for solarized color
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git

mv vim-colors-solarized ~/.vim/bundle/

