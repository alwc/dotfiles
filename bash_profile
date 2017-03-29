#------------------------------------------------------------------------------
# Aliases setup
#------------------------------------------------------------------------------

## rlwrap shortcut
alias rlsml="rlwrap sml"

## Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

## Listing, directories, and motion
alias ll="ls -alrtF"
alias la="ls -A"
alias l="ls -CF"
alias m='less'
alias ..="cd .."
alias ...="cd ..; cd .."
alias md="mkdir"
alias cl="clear"
alias du="du -ch"
alias treeacl="tree -A -C -L 2"

## Folder direct access
alias study="cd ~/Dropbox/_study_materials"
alias note="cd ~/Dropbox/notes"
alias note-m="cd ~/Dropbox/notes/misc"
alias note-p="cd ~/Dropbox/notes/programming"
alias course="cd ~/Courses"
alias mln="cd ~/Dropbox/_ml_notes"
alias mlc="cd ~/DataScience/ml_codebooks"
alias sn="cd ~/Dropbox/_study_notes"
alias todo="vim ~/Dropbox/notes/todo.md"
alias roadmap="cd ~/Dropbox/_study_materials; vim roadmap.txt"
alias scratch="cd ~/Dropbox/notes/scratch_pad/; vim"

alias brew-all="brew update && brew upgrade && brew cleanup && brew cask cleanup"
# `brew cu` command comes from 'https://github.com/buo/homebrew-cask-upgrade'
alias brew-cask-all="brew cu -a -y --cleanup"
alias docker-eval='eval "$(docker-machine env default)"'

## Network
alias lsp="lsof -i -n -P | grep LISTEN"

## grep options
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;31"

## postgres options
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost
alias start-pg='pg_ctl -l $PGDATA/server.log start'
alias stop-pg='pg_ctl stop -m fast'
alias show-pg-status='pg_ctl status'
alias restart-pg='pg_ctl reload'

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

# XGBoost
export PYTHONPATH=~/DataScience/xgboost/python-package

# Ensure user-installed binaries take precedence
export GOPATH=$HOME/go

# export PIOPATH=$HOME/PredictionIO-0.9.6/
export PIOPATH=$HOME/pio/
export ANACONDAPATH=$HOME/anaconda2

export PATH=$PATH
export PATH=$HOME/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$PIOPATH/bin:$PATH
export PATH=$ANACONDAPATH/bin:$PATH
# export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

# export MANPATH=$MANPATH
# export MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH

# Following settings comes from hackercodex.com
# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

#locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# vi editing mode in bash
set -o vi

# For Udacity's Android class
export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)

# The next line updates PATH for the Google Cloud SDK.
source '/Users/alexlee/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/alexlee/google-cloud-sdk/completion.bash.inc'

# Homebrew: "New shell sessions will start using GRC after you add this to your profile"
source '/usr/local/etc/grc.bashrc'
#source "`brew --prefix grc`/etc/grc.bashrc"

# For Homebrew's openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"
