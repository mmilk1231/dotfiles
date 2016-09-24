export PATH=/usr/local/bin:$PATH
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig

if [ -f "${HOME}/.my-settings" ]; then
    . "${HOME}/.my-settings"
fi

if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi
