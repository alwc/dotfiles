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
brew update && brew upgrade
brew install git
git clone git@github.com:alwc/dotfiles.git

echo ">>>>> Symlink dotfiles..."
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
mkdir $CONFIG_DIR
OS_DIR=osx # or ubuntu
WORKSPACE=home # or gn

ln -sf $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
ln -sf $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
ln -sf $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
ln -sf $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/$OS_DIR/bashrc_$WORKSPACE ~/.bashrc
ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/latexmkrc ~/.latexmkrc
ln -sf $DOTFILES_DIR/$OS_DIR/profile_$WORKSPACE ~/.profile
ln -sf $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/ctags.d ~/.ctags.d

echo ">>>>> Install Homebrew Bundle..."
brew bundle

echo ">>>>> Install vim-plug..."
curl -fLo ~/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>>>> Install Tmux Plugin Manager (TPM)..."
# https://github.com/tmux-plugins/tpm#installing-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# https://github.com/pyenv/pyenv-installer
echo ">>>>> Install pyenv (mainly for neovim)..."
if [ "$OS_DIR" = ubuntu ] ; then
    curl https://pyenv.run | bash
    sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi

# - https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
# Check the available python version using `pyenv install --list`
PYENV_3=3.8.0

pyenv install $PYENV_3

pyenv virtualenv $PYENV_3 neovim3

pyenv activate neovim3
pip install --upgrade pip
pip install neovim
pyenv which python

# Install Python library for neovim
pip install black mypy pylama bandit rope jedi

source deactivate neovim3

echo ">>>>> Install latex misc tool"
# Read
# - https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te
# - https://tex.stackexchange.com/questions/8357/how-to-have-local-package-override-default-package/8359#8359
# Install kbordermatrix.sty and Python's Pygments if you want to use latex's `minted` package

echo ">>>>> Install N"
curl -L https://git.io/n-install | bash -s -- -y
