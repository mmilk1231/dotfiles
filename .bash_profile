#!/bin/bash

if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi

if [ -f "${HOME}/.profile" ] ; then
    . "${HOME}/.profile"
fi

if [ -f "${HOME}/.git-completion.bash" ] ; then
    . "${HOME}/.git-completion.bash"
fi

if [ -f "${HOME}/.git-flow-completion.bash" ] ; then
    . "${HOME}/.git-flow-completion.bash"
fi
