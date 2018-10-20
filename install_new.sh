#!/bin/bash

###############################################################################
#                        Alex's OSX setup script                              #
###############################################################################

### **Change 'Caps Lock' to 'Escape' on OSX**
# Open 'System Preferences' -> 'Keyboard' ->
# Click on 'Modifier Keys...' -> 'Caps Lock Key' to 'Escape'

### **Install XCode command line tools**
xcode-select --install

### **Setup HostName**
USER_HOSTNAME=MBP
sudo scutil --set HostName ${USER_HOSTNAME}

### **Setup SSH keys**
# For Github:
# - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
# - https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
# - https://help.github.com/articles/changing-a-remote-s-url/#switching-remote-urls-from-https-to-ssh
# For Gitlab:
# - https://docs.gitlab.com/ee/ssh/

### **Install Homebrew**
# https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### **Install git then clone dotfiles to home directory**
brew update && brew upgrade && brew install git
git clone git@github.com:alwc/dotfiles.git

### **Symlink dotfiles**
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
OS_DIR=osx # or ubuntu

ln -s $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
ln -s $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
ln -s $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
ln -s $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -s $DOTFILES_DIR/$OS_DIR/bashrc ~/.bashrc
ln -s $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -s $DOTFILES_DIR/latexmkrc ~/.latexmkrc
ln -s $DOTFILES_DIR/$OS_DIR/profile ~/.profile
ln -s $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -s $DOTFILES_DIR/vimrc ~/.vimrc

### **Install Tmux Plugin Manager (TPM)**
# https://github.com/tmux-plugins/tpm#installing-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

### **Install pyenv (mainly for neovim)**
# - https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
# Check the available python version using `pyenv install --list`
PYENV_2=2.7.15
PYENV_3=3.6.2

pyenv install $PYENV_2
pyenv install $PYENV_3

pyenv virtualenv $PYENV_2 neovim2
pyenv virtualenv $PYENV_3 neovim3

pyenv activate neovim2
pip install --upgrade pip
pip install neovim
pyenv which python

pyenv activate neovim3
pip install --upgrade pip
pip install neovim
pyenv which python

# Install Python library for neovim (e.g. `yapf`)
pip install yapf flake8
ln -s `pyenv which flake8` /usr/local/bin/yapf

source deactiviate neovim3
