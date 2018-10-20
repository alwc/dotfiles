#!/bin/bash

# 1. Install Homebrew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# ln -s $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
# ln -s $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
# ln -s $DOTFILES_DIR/nvim $CONFIG_DIR/nvim

# ln -s $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -s $DOTFILES_DIR/osx/bashrc ~/.bashrc
# ln -s $DOTFILES_DIR/gitconfig ~/.gitconfig
# ln -s $DOTFILES_DIR/latexmkrc ~/.latexmkrc
ln -s $DOTFILES_DIR/osx/profile ~/.profile
# ln -s $DOTFILES_DIR/tmux.conf ~/.tmux.conf
# ln -s $DOTFILES_DIR/vimrc ~/.vimrc

# 3. Install Tmux Plugin Manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
