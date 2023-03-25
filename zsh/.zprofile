#!/bin/zsh
# +----------------------------------------------------------------------------
# | Environment variables
# +----------------------------------------------------------------------------
# Tell ls to be colourful
# export CLICOLOR=1
# export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Custom zsh prompt
# parse_git_branch() {
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
#
# export PROMPT='%F{white}%n%f%F{yellow}@%F{red}%m%f%F{white}:%F{green}%~%f%F{blue}$(parse_git_branch)
# %F{green}%#%f '
# autoload -U colors && colors
PS1=$'\e[0;31m$ \e[0m'

# # Initialize PATH variable
# export PATH="$PATH"
#
# # Update PATH variable
# export PATH="$HOME/bin:$PATH"
# export PATH="/usr/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"
# export PATH="/usr/local/sbin:$PATH"

# Set architecture flags
if [[ "$(uname -m)" == "x86_64" ]]; then
    # Intel
    # Ref: originally I followed the settings from hackercodex.com
    export ARCHFLAGS="-arch x86_64"
elif [[ "$(uname -m)" == "arm64" ]]; then
    # M1
    # Ref: https://stackoverflow.com/questions/64908116/correct-archflags-value-on-apple-silicon
    export ARCHFLAGS="-arch $(uname -m)"
fi

# Locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# For Homebrew's openssl
# export PATH="/usr/local/opt/openssl/bin:$PATH"

### zlib (Homebrew's keg)
# For compilers to find zlib you may need to set:
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
# export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

# +----------------------------------------------------------------------------
# | Google Cloud SDK
# +----------------------------------------------------------------------------
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'

if [[ "$(uname -m)" == "x86_64" ]]; then
    # Intel
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
elif [[ "$(uname -m)" == "arm64" ]]; then
    # M1
    source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

# +----------------------------------------------------------------------------
# | RVM
# +----------------------------------------------------------------------------
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load other profile settings that is shared between macOS and Ubuntu
# [ -f "$HOME/.shared_profile" ] && source "$HOME/.shared_profile"

# +----------------------------------------------------------------------------
# | Homebrew on M1
# +----------------------------------------------------------------------------
# https://stackoverflow.com/a/68494567/2282592
# export PATH=/opt/home

# +----------------------------------------------------------------------------
# | Pyenv
# +----------------------------------------------------------------------------
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#if [[ -n "$PS1" && -n "$ZSH_VERSION" ]]; then source ~/.zshrc; fi
