#!/bin/bash

if [ -f "${HOME}/.git-prompt.sh" ] ; then
    . "${HOME}/.git-prompt.sh"
fi

if [ -f "${HOME}/.git-completion.bash" ] ; then
    . "${HOME}/.git-completion.bash"
fi

if [ -f "${HOME}/.git-flow-completion.bash" ] ; then
    . "${HOME}/.git-flow-completion.bash"
fi

if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi
