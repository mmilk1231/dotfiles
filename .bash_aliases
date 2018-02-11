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


######## Aliases Depend on OS ########
if [ "${ARCHDIR}" == "Mac" -o "${ARCHDIR}" == "Mac64" ]; then
    ######## Mac ########
    alias ls='ls -Ga'
    alias chrome="open -a /Applications/Google\ Chrome.app"
    #alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab"
    alias matlab="/Applications/MATLAB_R2016a.app/bin/matlab -nodisplay"
    ######## End of Mac ########
elif [ "${ARCHDIR}" == "Linux" -o "${ARCHDIR}" == "Linux64" ]; then
    ######## Linux ########
    alias ls='ls --color=auto -a'
    alias matlab="/usr/local/MATLAB/R2016b/bin/matlab -nodisplay"
    ######## End of Linux ########
elif [ "${ARCHDIR}" == "Cygwin" -o "${ARCHDIR}" == "Cygwin64" ]; then
    ######## Cygwin ########
    alias runx='run xwin -multiwindow'
    alias open='cygstart'
    ######## End of Cygwin ########
fi
######## End of Aliases Depend on OS ########

######## Commmon Aliases ########
alias ll='ls -l'
alias emacs='\emacs -nw'
######## End of Common Aliases ########
