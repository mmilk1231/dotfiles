#!/bin/bash

# OSの判定
if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    OS='Cygwin'
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

# 詳細表示
alias ll='ls -l'

# MATLAB起動
if [ $OS == 'Mac' ]; then
   alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab"
   #alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab -nodisplay"
elif [ $OS == 'Linux' ]; then
    alias matlab="/usr/local/MATLAB/R2016b/bin/matlab -nodisplay"
fi

# Google Chrome起動
if [ $OS == 'Mac' ]; then
    alias chrome="open -a /Applications/Google\ Chrome.app"
fi
