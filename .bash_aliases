#!/bin/bash

alias ls='ls -G'
alias ll='ls -l'
alias emacs='\emacs -nw'

if [ "${ARCHDIR}" == "Mac" -o "${ARCHDIR}" == "Mac64" ]; then
    ######## Mac ########
    alias chrome="open -a /Applications/Google\ Chrome.app"
    #alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab"
    alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab -nodisplay"
    # end of Mac
elif [ "${ARCHDIR}" == "Linux" -o "${ARCHDIR}" == "Linux64" ]; then
    ######## Linux ########
    alias matlab="/usr/local/MATLAB/R2016b/bin/matlab -nodisplay"
    # end of Linux
elif [ "${ARCHDIR}" == "Cygwin" -o "${ARCHDIR}" == "Cygwin64" ]; then
    ######## Cygwin ########
    alias runx='run xwin -multiwindow'
    alias open='cygstart'
    # end of Cygwin
fi
