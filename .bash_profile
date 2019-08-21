#!/bin/bash

if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi

if [ -f "${HOME}/.profile" ] ; then
    . "${HOME}/.profile"
fi
