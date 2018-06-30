#!/bin/bash

#------------------------------------------------------------------------------
# Personal setup
#------------------------------------------------------------------------------

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Load in the git branch prompt script.
source ~/.git-prompt.sh

# Custom bash prompt
export PS1='\[\e[0;37m\]\u\[\e[0;33m\]@\[\e[1;31m\]$(scutil --get ComputerName)\[\e[0;37m\]:\[\e[0;32m\]\w\[\e[0;32m\]\[\e[0;38m\]$(__git_ps1 " git:(%s)")\n\[\e[0;32m\]\$\[\e[0;37m\] '

# export PIOPATH=$HOME/PredictionIO-0.9.6/
#export PIOPATH=$HOME/pio/

export PATH=$PATH
export PATH=$HOME/bin:$PATH
# export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

# export PATH=$PATH:/Users/alexlee/PredictionIO/bin
# export PATH=$PATH:/Users/alexlee/PredictionIO/bin
# export PATH=$PATH:/Users/alexlee/PredictionIO-0.9.6/bin
# export PATH=$PATH:$HOME/.local/bin

# export MANPATH=$MANPATH
# export MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH

# Following settings comes from hackercodex.com
# Set architecture flags
export ARCHFLAGS="-arch x86_64"

#locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/alexlee/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/alexlee/google-cloud-sdk/completion.bash.inc'

# Homebrew: "New shell sessions will start using GRC after you add this to your profile"
source '/usr/local/etc/grc.bashrc'
#source "`brew --prefix grc`/etc/grc.bashrc"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# For Homebrew's openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"
