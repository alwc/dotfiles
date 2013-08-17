# alias ls='ls -Fa'

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Custom bash prompt by me
export PS1='\[\e[0;37m\]\u\[\e[0;33m\]@\[\e[1;31m\]\h\[\e[0;37m\]:\[\e[0;32m\]\w\[\e[0;32m\]\n\$\[\e[0;37m\] '

# Setting PATH for Python 2.7 (Alex's note: For Enthought Python, 6.00x)
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# Following settings comes from hackercodex.com
# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure user-installed binaries take precedence
# export PATH=/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# Git PATH
# export PATH=/usr/local/git/bin:$PATH

#locale
export LANG=en_US.UTF-8
#export LC_COLLATE="en_US.UTF-8"
#export LC_CTYPE="en_US.UTF-8"
#export LC_MESSAGES="en_US.UTF-8"
#export LC_MONETARY="en_US.UTF-8"
#export LC_NUMERIC="en_US.UTF-8"
#export LC_TIME="en_US.UTF-8"
#export LC_ALL=

source "`brew --prefix grc`/etc/grc.bashrc"
