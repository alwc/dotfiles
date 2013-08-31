#------------------------------------------------------------------------------
# Aliases setup
#------------------------------------------------------------------------------

## Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

## Listing, directories, and motion
alias ll="ls -alrtF"
alias la="ls -A"
alias l="ls -CF"
alias dir="ls --color=auto --format=vertical"
alias vdir="ls --color=auto --fotmat=long"
alias m='less'
alias ..="cd .."
alias ...="cd ..; cd .."
alias md="mkdir"
alias cl="clear"
alias du="du -ch --max-depth=1"
alias treeacl="tree -A -C -L 2"

## grep options
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;31"

## sort options
## Read: http://www.gnu.org/software/coreutils/faq/coreutils-faq.html#Sort-does-not-sort-in-normal-order_0021
unset LANG
export LC_ALL=POSIX

#------------------------------------------------------------------------------
# Personal setup
#------------------------------------------------------------------------------

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Custom bash prompt
export PS1='\[\e[0;37m\]\u\[\e[0;33m\]@\[\e[1;31m\]$(scutil --get ComputerName)\[\e[0;37m\]:\[\e[0;32m\]\w\[\e[0;32m\]\n\$\[\e[0;37m\] '

# Ensure user-installed binaries take precedence
export PATH=$PATH
export PATH=$HOME/bin:$PATH
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
export LANG=en_US.UTF-8

source "`brew --prefix grc`/etc/grc.bashrc"
