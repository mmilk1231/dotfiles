export PATH=/usr/local/bin:$PATH
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig

export PATH="${HOME}/.cask/bin:$PATH"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"

export CUDAROOT=/usr/local/cuda
export PATH=$PATH:$CUDAROOT/bin
export LD_LIBRARY_PATH=$CUDAROOT/lib64:$CUDAROOT/lib:$LD_LIBRARY_PATH
export CPATH=$CPATH:$CUDAROOT/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDAROOT/include
export CUDA_INC_DIR=$CUDAROOT/bin:$CUDA_INC_DIR

if [ -f "${HOME}/.bashrc" ] ; then
    . "${HOME}/.bashrc"
fi
