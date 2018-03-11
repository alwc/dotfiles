#------------------------------------------------------------------------------
# Aliases setup
#------------------------------------------------------------------------------

alias vim="nvim"

if [ "$(uname)" == "Darwin" ]; then
    alias git="hub"
fi

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

## Git
export GIT_EDITOR="nvim"

# Locate virtualenvwrapper binary
#if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#    export VENVWRAP=/usr/local/bin/virtualenvwrapper.sh
#fi

# if [ ! -z $VENVWRAP ]; then
#     # virtualenvwrapper -------------------------------------------------
#     # make sure env directory exists; else create it
#     [ -d $HOME/Virtualenvs ] || mkdir -p $HOME/Virtualenvs
#     export WORKON_HOME=$HOME/Virtualenvs
#     source $VENVWRAP
#
#     # virtualenv --------------------------------------------------------
#     # virtualenv should use Distribute instead of legacy setuptools
#     export VIRTUALENV_USE_DISTRIBUTE=true
#
#     # pip ---------------------------------------------------------------
#     # centralized location for new virtual environments
#     export PIP_VIRTUALENV_BASE=$WORKON_HOME
#     # pip should only run if there is a virtualenv currently activated
#     # export PIP_REQUIRE_VIRTUALENV=true
#     # cache pip-installed packages to avoid re-downloading
#     export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# fi

syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

syspip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}


## Kaggle
kpython() {
    if [ "$(uname)" == "Darwin" ]; then
        echo '[TODO] Do something under Mac OS X platform.'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
      nvidia-docker run -v ~/shared_folder:/shared_folder --rm -it \
          kaggle/python python3 "$@"
    fi
}

ikpython() {
    if [ "$(uname)" == "Darwin" ]; then
        echo '[TODO] Do something under Mac OS X platform.'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        nvidia-docker run -v ~/shared_folder:/shared_folder --rm -it \
            kaggle/python ipython
    fi
}

kjupyter() {
    if [ "$(uname)" == "Darwin" ]; then
        echo '[TODO] Do something under Mac OS X platform.'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Do something under GNU/Linux platform
        docker run --runtime=nvidia -v ~/shared_folder:/shared_folder -p 8888:8888 \
            -p 6006:6006 --rm -it kaggle/python jupyter notebook --no-browser \
            --ip="0.0.0.0" --notebook-dir=/shared_folder --allow-root
    fi
}

pytjupyter() {
    if [ "$(uname)" == "Darwin" ]; then
        echo '[TODO] Do something under Mac OS X platform.'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        docker run --runtime=nvidia -it --rm -p 8888:8888 -p 6006:6006 \
            -v ~/shared_folder:/shared_folder floydhub/pytorch:0.3.0-gpu.cuda9cudnn7-py3.22
    fi
}

tfjupyter() {
    if [ "$(uname)" == "Darwin" ]; then
        echo '[TODO] Do something under Mac OS X platform.'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        docker run --runtime=nvidia -it --rm -p 8888:8888 -p 6006:6006 \
            -v ~/shared_folder:/shared_folder floydhub/tensorflow:1.5.0-gpu.cuda9cudnn7-py3_aws.22
    fi
}
