export PATH=/usr/local/bin:$PATH
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
export PATH=$PATH:"${HOME}/bin"

# anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
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

# cuda
export CUDAROOT=/usr/local/cuda
export PATH=$PATH:$CUDAROOT/bin
export LD_LIBRARY_PATH=$CUDAROOT/lib64:$CUDAROOT/lib:$LD_LIBRARY_PATH
export CPATH=$CPATH:$CUDAROOT/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDAROOT/include
export CUDA_INC_DIR=$CUDAROOT/bin:$CUDA_INC_DIR

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

if [ -f "${HOME}/.bashrc" ] ; then
    . "${HOME}/.bashrc"
fi
