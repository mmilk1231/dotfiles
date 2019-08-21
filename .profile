#!/bin/bash

######## OS Recognition ########
OS=`uname -s | cut -d_ -f1`
CPU=`uname -m`

if [ "${OS}" == "Darwin" ]; then
    if [ "${CPU}" == "x86_64" ]; then
	export ARCHDIR=Mac64
    else
	export ARCHDIR=Mac
    fi
elif [ "${OS}" == "CYGWIN" ]; then
    if [ "${CPU}" == "x86_64" ]; then
	export ARCHDIR=Cygwin64
    else
	export ARCHDIR=Cygwin
    fi
elif [ "${OS}" == "Linux" ]; then
    if [ "${CPU}" == "x86_64" ]; then
	export ARCHDIR=Linux64
    else
	export ARCHDIR=Linux
    fi
else
    echo "Your platform ($OS) is not supported."
    exit 1
fi
######## End of OS Recognition ########


######## Commmon Paths ########
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib

# git-prompt
if [[ `type -t __git_ps1` ]] ; then
    export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi

# anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH=$PATH:${HOME}/.anyenv/bin
    eval "$(anyenv init -)"
fi

# pyenv-virtualenv
if [ -d $HOME/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ] ; then
    eval "$(pyenv virtualenv-init -)"
fi

# python
if [ -d $HOME/.anyenv/envs/pyenv ] ; then
    export PKG_CONFIG_PATH="$(pyenv prefix)/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

# roboschool
export ROBOSCHOOL_PATH=$HOME/Documents/roboschool
if [ -d $ROBOSCHOOL_PATH ] ; then
    export C_INCLUDE_PATH=$(pyenv prefix)/include:$(pyenv prefix)/include/python3.7m
    export CPLUS_INCLUDE_PATH=$(pyenv prefix)/include:$(pyenv prefix)/include/python3.7m
fi

# qt
export PATH="/usr/local/opt/qt/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig:$PKG_CONFIG_PATH"

# cask
export PATH="${HOME}/.cask/bin:$PATH"

# libffi
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"

# gettext
export LD_LIBRARY_PATH="/usr/local/opt/gettext/lib/:$LD_LIBRARY_PATH"
export LIBRARY_PATH="/usr/local/opt/gettext/lib/:$LIBRARY_PATH"
export C_INCLUDE_PATH="/usr/local/opt/gettext/include:$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH="/usr/local/opt/gettext/include:$CPLUS_INCLUDE_PATH"

######## End of Common Paths ########


######## Paths Depend on OS ########
if [ "${ARCHDIR}" == "Mac" -o "${ARCHDIR}" == "Mac64" ]; then
    ######## Mac ########
    export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
    ######## End of Mac ########
elif [ "${ARCHDIR}" == "Linux" -o "${ARCHDIR}" == "Linux64" ]; then
    ######## Linux ########
    # cuda
    export CUDAROOT=/usr/local/cuda
    export PATH=$PATH:$CUDAROOT/bin
    export LD_LIBRARY_PATH=$CUDAROOT/lib64:$CUDAROOT/lib:$LD_LIBRARY_PATH
    export CPATH=$CPATH:$CUDAROOT/include
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDAROOT/include
    export CUDA_INC_DIR=$CUDAROOT/bin:$CUDA_INC_DIR

    # texlive
    export PATH="/usr/local/texlive/2018/bin/x86_64-linux:$PATH"
    ######## End of Linux ########
elif [ "${ARCHDIR}" == "Cygwin" -o "${ARCHDIR}" == "Cygwin64" ]; then
    ######## Cygwin ########
    :
    ######## End of Cygwin ########
fi
######## End of Paths Depend on OS ########

