#! /bin/bash
sudo apt update
sudo apt install pgcli tmux git-core bash-completion

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
git clone https://github.com/wincent/Command-T.git ~/.vim/bundle/Command-T
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

# special steps for solarized color
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/kristijanhusak/vim-hybrid-material ~/.vim/bundle/vim-hybrid-material

###########
# COPY dot files into home directory
cp dotfiles/bashrc ~/.bashrc
cp dotfiles/bash_profile ~/.bash_profile
cp dotfiles/profile ~/.profile
cp dotfiles/vimrc ~/.vimrc
cp dotfiles/tmux.conf ~/.tmux.conf
cp dotfiles/gitconfig ~/.gitconfig

source ~/.bash_profile

##########
# additional configurations
echo 'set completion-ignore-case On' >> ~/.inputrc
echo '*.swp' >> ~/.gitignore && git config --global core.excludesfile ~/.gitignore
