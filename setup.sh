#!/usr/bin/env bash

# +---------------------------------------------------------------------------
# | Things to setup on a new OSX machine
# +---------------------------------------------------------------------------
# >>>>> Change "Caps Lock" to "Escape" on OSX
# 1. Open "System Preferences" -> "Keyboard" -> "Keyboard"
# 2. Click on "Modifier Keys..."
# 3. Change "Caps Lock Key" to "Escape"
#
# >>>>> Maximize the "Key repeat" and "Delay Until Repeat" speed
# 1. Open "System Preferences" -> "Keyboard" -> "Keyboard"
# 2. Slide "Key Repeat" to "Fast" (right-most option)
# 2. Slide "Delay Until Repeat" to "Short" (right-most option)
#
# >>>>> Minimize the 'Alert volume' in 'Sound'.
# 1. Open "System Preferences" -> "Sound"
# 2. Slide "Alert volume" to lowest (left-most option)
#
# >>>>> Setup space support for Amethyst
# 1. Open "System Preferences" -> "Keyboard" -> "Shortcuts"
# 2. Click on "Mission Control"
# 3. Tick all "Switch to Desktop {1..N}"
#
# +---------------------------------------------------------------------------
# | Setup SSH keys
# +---------------------------------------------------------------------------
# >>>>> Github:
# - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
# - https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
# - https://help.github.com/articles/changing-a-remote-s-url/#switching-remote-urls-from-https-to-ssh
# >>>>>> Gitlab:
# - https://docs.gitlab.com/ee/ssh/

DOTFILES_DIR=~/dotfiles
if [ "$(uname)" == "Darwin" ]; then
    OS_DIR=osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OS_DIR=ubuntu
fi

# Exit script without exiting shell. This is like press `Ctrl-C`
# Read: https://stackoverflow.com/a/17153661
exit_script() {
  kill -INT $$
}

install_osx_basics() {
    echo ">>>>> Install XCode command line tools..."
    xcode-select --install

    echo ">>>>> Setup HostName..."
    USER_HOSTNAME=AlexMBP
    sudo scutil --set HostName ${USER_HOSTNAME}
}

install_homebrew_and_git() {
    echo ">>>>> Install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Need to eval it first before `brew` works
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    echo ">>>>> Install git"
    brew update && brew upgrade
    brew install git
}

clone_dotfiles() {
    git clone git@github.com:alwc/dotfiles.git $DOTFILES_DIR
    cd $DOTFILES_DIR
}

install_homebrew_bundle() {
    brew bundle --file=$DOTFILES_DIR/$OS_DIR/Brewfile

    # To install useful FZF key bindings and fuzzy completion:
    $(brew --prefix)/opt/fzf/install

    # TEMP fix for ripgrep on Ubuntu
    if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        . $DOTFILES_DIR/$OS_DIR/install_ripgrep.sh
    fi
    cd $DOTFILES_DIR
}

_setup_osx_default_settings() {
    echo ">>>>> Setup OSX default settings..."
    source $DOTFILES_DIR/osx/settings.sh
}

symlink_dotfiles() {
    CONFIG_DIR=~/.config
    mkdir -p $CONFIG_DIR

    if [ "$(uname)" == "Darwin" ]; then
        ln -sf $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
        ln -sf $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
        ln -sf $DOTFILES_DIR/latexmkrc ~/.latexmkrc

        # Setup OSX default settings
        _setup_osx_default_settings
    fi
ln -sf $DOTFILES_DIR/cross_platform/shared_bashrc ~/.shared_bashrc
    ln -sf $DOTFILES_DIR/cross_platform/shared_profile ~/.shared_profile
    ln -sf $DOTFILES_DIR/cross_platform/bash_profile ~/.bash_profile
    ln -sf $DOTFILES_DIR/$OS_DIR/bashrc ~/.bashrc
    ln -sf $DOTFILES_DIR/$OS_DIR/profile ~/.profile
    ln -sf $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
    ln -sf $DOTFILES_DIR/nvim/coc/coc-settings-${OS_DIR}.json $CONFIG_DIR/nvim/coc-settings.json
    ln -sf $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
    ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
    ln -sf $DOTFILES_DIR/ctags.d ~/.ctags.d
}

install_tmux_plugin_manager() {
    echo ">>>>> Install Tmux Plugin Manager (TPM)..."
    # https://github.com/tmux-plugins/tpm#installing-plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # Note: if you are getting "open terminal failed: missing or unsuitable
    # terminal: xterm-kitty". You need to ssh in using the following command first
    # `$ kitty +kitten ssh myserver`
    # Read: https://github.com/kovidgoyal/kitty/issues/320
    tmux source ~/.tmux.conf
}

install_n() {
    # Install N (Node version management)
    echo ">>>>> Install N"
    curl -L https://git.io/n-install | bash -s -- -y
}

setup_neovim_env() {
    # Note: if build failed, read https://github.com/pyenv/pyenv/wiki/common-build-problems

    # Automatic exit from bash shell script on error
    set -e

    # - https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
    # Check the available python version using `pyenv install --list`
    PYENV_2=2.7.16
    pyenv install $PYENV_2

    PYENV_3=3.7.7
    pyenv install $PYENV_3
    pyenv virtualenv $PYENV_3 neovim3
    pyenv activate neovim3
    pip install --upgrade pip
    pip install neovim
    pyenv which python

    # Install Python library for neovim
    pip install black mypy pylama bandit rope jedi isort

    source deactivate neovim3

    # Set the system python
    pyenv global $PYENV_3

    # Install Node's neovim plugin
    [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || npm install -g neovim
}

setup_zotero_sym_link() {
    local ZOTERO_PATH=~/Zotero
    local ATTACHMENT_PATH=~/Dropbox/references/attachments

    # Alex: For some reasons it doesn't work in bash script, but it works
    # when I run `ln -sf` command in shell.
    [ -d "`eval echo ${ZOTERO_PATH}`" ] && [ -d "`eval echo ${ATTACHMENT_PATH}`" ] && \
        ln -sf ${ATTACHMENT_PATH} ${ZOTERO_PATH}/storage
}

# install_latex_misc_tools() {
#     echo ">>>>> Install latex misc tool"
#     # Read
#     # - https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te
#     # - https://tex.stackexchange.com/questions/8357/how-to-have-local-package-override-default-package/8359#8359
#     # Install kbordermatrix.sty and Python's Pygments if you want to use latex's `minted` package
# }

# Create a select menu in shell script
# Read: https://askubuntu.com/a/55901
options=(
  "Install OSX basics"
  "Clone my dotfiles"
  "Install Homebrew and Git"
  "Install Homebrew bundle"
  "Create symlink to my dotfiles"
  "Install Tmux plugin manager"
  "Install n (Node version management)"
  "Setup Neovim environment"
  "Setup Zotero storage symlink"
)

# Make each menu selections in 1 line instead of multiple selections in 1 line
# Read: https://unix.stackexchange.com/a/293605
COLUMNS=10

sep="=================================================="
title="Select the type of container that you want to run:"

echo $'\n'"$sep"
echo "$title"
echo "$sep"$'\n'

PS3=$'\n'"Select an option (1 - $((${#options[@]} + 1))): "

select opt in "${options[@]}" "QUIT"; do
  case "$REPLY" in

  1) install_osx_basics && exit_script ;;
  2) clone_dotfiles && exit_script ;;
  3) install_homebrew_and_git && exit_script ;;
  4) install_homebrew_bundle && exit_script ;;
  5) symlink_dotfiles && exit_script ;;
  6) install_tmux_plugin_manager && exit_script ;;
  7) install_n && exit_script ;;
  8) setup_neovim_env && exit_script ;;
  9) setup_zotero_sym_link && exit_script ;;

  $((${#options[@]} + 1)))
    echo "Goodbye!"
    break
    ;;
  *)
    echo "Invalid option. Try another one."
    continue
    ;;
  esac
done
