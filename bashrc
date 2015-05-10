# Locate virtualenvwrapper binary
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export VENVWRAP=/usr/local/bin/virtualenvwrapper.sh
fi

if [ ! -z $VENVWRAP ]; then
    # virtualenvwrapper -------------------------------------------------
    # make sure env directory exists; else create it
    [ -d $HOME/Virtualenvs ] || mkdir -p $HOME/Virtualenvs
    export WORKON_HOME=$HOME/Virtualenvs
    source $VENVWRAP

    # virtualenv --------------------------------------------------------
    # virtualenv should use Distribute instead of legacy setuptools
    export VIRTUALENV_USE_DISTRIBUTE=true

    # pip ---------------------------------------------------------------
    # centralized location for new virtual environments
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    # pip should only run if there is a virtualenv currently activated
    export PIP_REQUIRE_VIRTUALENV=true
    # cache pip-installed packages to avoid re-downloading
    export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
fi

syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

syspip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
