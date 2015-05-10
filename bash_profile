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
alias todo="vim ~/Dropbox/notes/to_do.txt"
alias roadmap="cd ~/Dropbox/_study_materials; vim roadmap.txt"
alias scratch="cd ~/Dropbox/notes/scratch_pad/; vim"

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

# Custom bash prompt
export PS1='\[\e[0;37m\]\u\[\e[0;33m\]@\[\e[1;31m\]$(scutil --get ComputerName)\[\e[0;37m\]:\[\e[0;32m\]\w\[\e[0;32m\]\n\$\[\e[0;37m\] '

# Ensure user-installed binaries take precedence
export GOPATH=$HOME/go

export PATH=$PATH
export PATH=$HOME/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

# Following settings comes from hackercodex.com
# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

#locale
export LANG="en_US.UTF-8"

# vi editing mode in bash
set -o vi

source "`brew --prefix grc`/etc/grc.bashrc"

# For Udacity's Android class
export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)
