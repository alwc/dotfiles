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
case "$(uname -s)" in
    Darwin) OS_DIR=osx ;;
    Linux*) OS_DIR=ubuntu ;;
    *) echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac

# Resolve the Homebrew prefix for the current OS/arch.
_brew_prefix() {
    case "$(uname -s)-$(uname -m)" in
        Darwin-arm64)  echo /opt/homebrew ;;
        Darwin-x86_64) echo /usr/local ;;
        Linux-*)       echo /home/linuxbrew/.linuxbrew ;;
    esac
}

# Exit script without exiting shell. This is like press `Ctrl-C`
# Read: https://stackoverflow.com/a/17153661
exit_script() {
  kill -INT $$
}

install_osx_basics() {
    echo ">>>>> Install XCode command line tools..."
    xcode-select --install

    echo ">>>>> Setup HostName..."
    read -p "Enter hostname for this machine: " USER_HOSTNAME
    sudo scutil --set HostName "${USER_HOSTNAME}"

    echo ">>>>> Install zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    if [ "$(uname -m)" == "arm64" ]; then
        echo ">>>>> Rosetta2..."
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    fi
}

install_homebrew_and_git() {
    echo ">>>>> Install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

    brew update && brew upgrade

    if [ "$OS_DIR" = "osx" ]; then
        brew install --cask 1password
        brew install 1password-cli
    fi
}

clone_dotfiles() {
    if [ -d "$DOTFILES_DIR" ]; then
        echo ">>>>> $DOTFILES_DIR already exists, skipping clone."
    else
        git clone https://github.com/alwc/dotfiles.git $DOTFILES_DIR
    fi
    cd $DOTFILES_DIR
}

install_ctags_and_gtags() {
    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

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

install_homebrew_basic() {
    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

    brew install \
        tmux \
        fzf \
        claude-code \
        uv \
        neovim \
        ripgrep \
        ripgrep-all \
        fd \
        tree \
        smug

    if [ "$OS_DIR" = "osx" ]; then
        brew install --cask \
            kitty \
            obsidian \
            google-chrome \
            codex \
            codex-app
    fi
}

install_kitty_terminfo() {
    # Ship the host's xterm-kitty terminfo to a remote machine so keys like
    # Delete, arrows, Home, and End behave correctly when ssh'ing into it.
    #
    # Why this is needed:
    #   - tmux (see tmux/tmux.conf) sets default-terminal=xterm-kitty on macOS,
    #     so $TERM inside tmux is "xterm-kitty".
    #   - When you ssh into a remote VM from inside tmux, that $TERM travels
    #     with the session.
    #   - Most fresh VMs don't have an xterm-kitty terminfo entry (only
    #     machines that have kitty installed do), so the remote shell's line
    #     editor can't decode the escape sequences your keys emit. Symptom:
    #     Delete moves the cursor forward instead of erasing, arrow keys
    #     insert garbage, etc.
    #   - `kitty +kitten ssh` would normally install terminfo automatically,
    #     but it can't pass its keyboard protocol through tmux, so we copy
    #     the entry by hand.
    #
    # Run once per fresh VM. Compiles into ~/.terminfo on the remote (no sudo).
    #
    # NOTE: don't rely on `set -e` here — this function is invoked as
    # `install_kitty_terminfo && exit_script`, and bash disables errexit
    # inside any command whose exit status is being inspected by &&/||/if.
    # Check pipeline status explicitly with `pipefail`.

    if ! command -v infocmp >/dev/null 2>&1; then
        echo ">>>>> 'infocmp' not found on host — install ncurses first."
        return 1
    fi

    if ! infocmp -a xterm-kitty >/dev/null 2>&1; then
        echo ">>>>> No xterm-kitty terminfo on host. Install kitty first."
        return 1
    fi

    read -p "Remote target (user@host): " REMOTE
    if [ -z "$REMOTE" ]; then
        echo ">>>>> No remote provided, aborting."
        return 1
    fi

    (
        set -o pipefail
        infocmp -a xterm-kitty | ssh "$REMOTE" 'tic -x -o ~/.terminfo /dev/stdin'
    )
    local rc=$?
    if [ $rc -ne 0 ]; then
        echo ">>>>> Failed to install xterm-kitty terminfo on $REMOTE (exit $rc)"
        return $rc
    fi
    echo ">>>>> Installed xterm-kitty terminfo on $REMOTE"
}

install_homebrew_bundle() {
    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

    brew bundle --jobs=auto --file=$DOTFILES_DIR/$OS_DIR/Brewfile

    # fzf shell integration (key bindings + fuzzy completion) is set up in
    # the shell rc files via `eval "$(fzf --bash)"` / `source <(fzf --zsh)`,
    # per https://github.com/junegunn/fzf#setting-up-shell-integration. No
    # install script needed — brew provides the `fzf` binary.

    # TEMP fix for ripgrep on Ubuntu
    if [ "$OS_DIR" = "ubuntu" ]; then
        . $DOTFILES_DIR/$OS_DIR/install_ripgrep.sh
    fi
    cd $DOTFILES_DIR
}

install_mise_and_node() {
    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

    echo ">>>>> Install mise..."
    brew install mise

    echo ">>>>> Install Node.js via mise..."
    mise use -g node@latest
}

_setup_osx_default_settings() {
    echo ">>>>> Setup OSX default settings..."
    source $DOTFILES_DIR/osx/settings.sh
}

symlink_dotfiles() {
    CONFIG_DIR=~/.config
    mkdir -p $CONFIG_DIR

    if [ "$(uname)" == "Darwin" ]; then
        ln -sfn $DOTFILES_DIR/karabiner $CONFIG_DIR/karabiner
        ln -sfn $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
        ln -sf $DOTFILES_DIR/latexmkrc ~/.latexmkrc

        # Setup OSX default settings
        _setup_osx_default_settings
    fi
    ln -sf $DOTFILES_DIR/cross_platform/shared_bashrc ~/.shared_bashrc
    ln -sf $DOTFILES_DIR/cross_platform/shared_profile ~/.shared_profile
    ln -sf $DOTFILES_DIR/cross_platform/bash_profile ~/.bash_profile
    ln -sf $DOTFILES_DIR/$OS_DIR/bashrc ~/.bashrc
    ln -sf $DOTFILES_DIR/$OS_DIR/profile ~/.profile
    ln -sfn $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
    ln -sf $DOTFILES_DIR/nvim/coc/coc-settings-${OS_DIR}.json $CONFIG_DIR/nvim/coc-settings.json
    ln -sf $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
    ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
    ln -sfn $DOTFILES_DIR/ctags.d ~/.ctags.d

    ln -sf $DOTFILES_DIR/zsh/zprofile ~/.zprofile
    ln -sf $DOTFILES_DIR/zsh/zshrc ~/.zshrc
}

install_tmux_plugin_manager() {
    echo ">>>>> Install Tmux Plugin Manager (TPM)..."
    # https://github.com/tmux-plugins/tpm#installing-plugins
    if [ -d ~/.tmux/plugins/tpm ]; then
        echo ">>>>> ~/.tmux/plugins/tpm already exists, skipping clone."
    else
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # Reload config only if a tmux server is already running. On a fresh
    # machine there's no server yet — the conf will be picked up the first
    # time the user starts tmux.
    #
    # Note: if you are getting "open terminal failed: missing or unsuitable
    # terminal: xterm-kitty". You need to ssh in using the following command first
    # `$ kitty +kitten ssh myserver`
    # Read: https://github.com/kovidgoyal/kitty/issues/320
    if tmux info >/dev/null 2>&1; then
        tmux source ~/.tmux.conf
    else
        echo ">>>>> No tmux server running — skipping config reload."
        echo "      Start tmux and press prefix + I to install TPM plugins."
    fi
}

setup_neovim_env() {
    # Using uv for Python environment management

    # Automatic exit from bash shell script on error
    set -e

    # Temporarily export the Homebrew path
    export PATH="$(_brew_prefix)/bin:$PATH"

    if ! command -v uv >/dev/null 2>&1; then
        echo ">>>>> Install uv via Homebrew..."
        brew install uv
    fi

    # Install Python versions using uv
    uv python install 3.12.6

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
  "Install Homebrew basic packages"
  "Install Homebrew bundle"
  "Install mise and Node.js"
  "Install Tmux plugin manager"
  "Setup Neovim environment"
  "Install xterm-kitty terminfo on a remote VM"
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
  6) install_homebrew_basic && exit_script ;;
  7) install_homebrew_bundle && exit_script ;;
  8) install_mise_and_node && exit_script ;;
  9) install_tmux_plugin_manager && exit_script ;;
  10) setup_neovim_env && exit_script ;;
  11) install_kitty_terminfo && exit_script ;;

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
