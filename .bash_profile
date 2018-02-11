export PATH=/usr/local/bin:$PATH
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"

if [ -f "${HOME}/.bashrc" ] ; then
    . "${HOME}/.bashrc"
fi
