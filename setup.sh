#!/usr/bin/env bash

# +---------------------------------------------------------------------------
# | Things to setup on a new OSX machine
# +---------------------------------------------------------------------------
# >>>>> Change "Caps Lock" to "Escape" on OSX
# 1. Open "System Preferences" -> "Keyboard" -> "Keyboard Shortcuts"
# 2. Click on "Modifier Keys..."
# 3. Change "Caps Lock Key" to "Escape"
#
# >>>>> Maximize the "Key repeat" and "Delay Until Repeat" speed
# 1. Open "System Preferences" -> "Keyboard"
# 2. Slide "Key Repeat" to "Fast" (right-most option)
# 2. Slide "Delay Until Repeat" to "Short" (right-most option)

# >>>>> Maximize the "Tracking speed"
# 1. Open "System Preferences" -> "Trackpad"
# 2. Click on "Point & Click" tab
# 2. Slide "Tracking speed" to "Fast" (right-most option)
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
# >>>>> Setup Karabiner-Elements (keyboard customizer)
# 1. Open "Karabiner-Elements" and follow the instructions.
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

    echo ">>>>> Install zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo ">>>>> Rosetta2..."
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
}

install_homebrew_and_git() {
    echo ">>>>> Install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Temporarily export the Homebrew path
    if [ "$(uname -m)" == "x86_64" ]; then
        export PATH=/usr/local/bin:$PATH
    elif [ "$(uname -m)" == "arm64" ]; then
        export PATH=/opt/homebrew/bin:$PATH
    else
        export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
    fi

    echo ">>>>> Install git"
    brew update && brew upgrade
    brew install git
}

clone_dotfiles() {
    git clone git@github.com:alwc/dotfiles.git $DOTFILES_DIR
    cd $DOTFILES_DIR
}

install_ctags_and_gtags() {
    # Temporarily export the Homebrew path
    if [ "$(uname -m)" == "x86_64" ]; then
        export PATH=/usr/local/bin:$PATH
    elif [ "$(uname -m)" == "arm64" ]; then
        export PATH=/opt/homebrew/bin:$PATH
    else
        export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
    fi

    # Install universal-ctags
    # ref: https://gist.github.com/alexshgov/7e5ed7841667c66ef5ca4f31664714a9
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags

    # Install gtags (GNU Global)
    # ref: https://www.gnu.org/software/global/download.html
    GTAGS_VER="6.6.8"
    GTAGS_URL=https://ftp.gnu.org/pub/gnu/global/global-${GTAGS_VER}.tar.gz
    wget -c ${GTAGS_URL} -O - | tar -xz
    pushd global-${GTAGS_VER}
    ./configure --with-universal-ctags=$(brew --prefix)/bin/ctags
    make && make install
    popd
    which gtags
}

install_homebrew_bundle() {
    # Temporarily export the Homebrew path
    if [ "$(uname -m)" == "x86_64" ]; then
        export PATH=/usr/local/bin:$PATH
    elif [ "$(uname -m)" == "arm64" ]; then
        export PATH=/opt/homebrew/bin:$PATH
    else
        export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
    fi

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

    ln -sf $DOTFILES_DIR/zsh/zprofile ~/.zprofile
    ln -sf $DOTFILES_DIR/zsh/zshrc ~/.zshrc
    ln -sf $DOTFILES_DIR/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
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

setup_neovim_env() {
    # Using uv for Python environment management

    # Automatic exit from bash shell script on error
    set -e

    # Install Python versions using uv
    uv python install 3.12.6 2.7.18

    # Set the default Python version
    uv python pin 3.12.6

    # Create a virtual environment for Neovim using Python 3.9.4
    uv venv neovim3 --python 3.12.6
    source neovim3/bin/activate
    
    # Install Python packages for neovim
    uv pip install pynvim black mypy pylama bandit rope jedi isort

    deactivate

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
  "Create symlink to my dotfiles"
  "Install ctags and gtags (only if homebrew failed installing)"
  "Install Homebrew bundle"
  "Install Tmux plugin manager"
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
  4) symlink_dotfiles && exit_script ;;
  5) install_ctags_and_gtags && exit_script ;;
  6) install_homebrew_bundle && exit_script ;;
  7) install_tmux_plugin_manager && exit_script ;;
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
