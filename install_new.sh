#!/bin/bash

# 1. Install Homebrew
# https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 2. Install git then clone dotfiles to home directory
brew update && brew upgrade && brew install git
git clone git@github.com:alwc/dotfiles.git

# 3. Symlink dotfiles
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

ln -s $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
ln -s $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
ln -s $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
ln -s $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -s $DOTFILES_DIR/osx/bashrc ~/.bashrc
ln -s $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -s $DOTFILES_DIR/latexmkrc ~/.latexmkrc
ln -s $DOTFILES_DIR/osx/profile ~/.profile
ln -s $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -s $DOTFILES_DIR/vimrc ~/.vimrc

# 4. Install Tmux Plugin Manager (TPM)
# https://github.com/tmux-plugins/tpm#installing-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
