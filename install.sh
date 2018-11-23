#!/bin/bash

###############################################################################
#                        Alex's OSX setup script                              #
###############################################################################

# # >>>>> Change 'Caps Lock' to 'Escape' on OSX
# Open 'System Preferences' -> 'Keyboard' ->
# Click on 'Modifier Keys...' -> 'Caps Lock Key' to 'Escape'

# >>>>> Maximize the 'Key repeat' and 'Delay Until Repeat' speed in 'Keyboard'.

# >>>>> Minimize the 'Alert volume' in 'Sound'.

# >>>>> Setup space support for Amethyst
# Go to 'Keyboard' -> 'Keyboard Shortcuts' -> Turn on 'Switch to Desktop {1..N}'

echo ">>>>> Install XCode command line tools..."
xcode-select --install

echo ">>>>> Setup HostName..."
USER_HOSTNAME=AlexMBP
sudo scutil --set HostName ${USER_HOSTNAME}

# >>>>> Setup SSH keys
# For Github:
# - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
# - https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
# - https://help.github.com/articles/changing-a-remote-s-url/#switching-remote-urls-from-https-to-ssh
# For Gitlab:
# - https://docs.gitlab.com/ee/ssh/

echo ">>>>> Install Homebrew..."
# https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ">>>>> Install git then clone dotfiles to home directory..."
brew update && brew upgrade && brew install git
git clone git@github.com:alwc/dotfiles.git

echo ">>>>> Symlink dotfiles..."
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
OS_DIR=osx # or ubuntu

ln -sf $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
ln -sf $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
ln -sf $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
ln -sf $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/$OS_DIR/bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/latexmkrc ~/.latexmkrc
ln -sf $DOTFILES_DIR/$OS_DIR/profile ~/.profile
ln -sf $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/ctags.d ~/.ctags.d

echo ">>>>> Install Homebrew Bundle..."
brew bundle

echo ">>>>> Install vim-plug..."
curl -fLo ~/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>>>> Install Tmux Plugin Manager (TPM)..."
# https://github.com/tmux-plugins/tpm#installing-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

echo ">>>>> Install pyenv (mainly for neovim)..."
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

source deactivate neovim3
