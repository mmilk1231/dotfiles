#!/bin/sh

DOTDIR=$(cd $(dirname $0) && pwd)
BUCKUPDIR=$DOTDIR/backup_`date +%Y%m%d%H%M%S`

FILES=( ".bash_profile" ".bashrc" ".bash_aliases"
	".emacs.d/init.el" ".emacs.d/Cask"
        ".gitconfig_global")

echo mkdir $BUCKUPDIR
mkdir $BUCKUPDIR
for file in ${FILES[@]} ; do
    echo cp $HOME/$file $BUCKUPDIR
    echo ln -sf $DOTDIR/$file $HOME/$file
    cp $HOME/$file $BUCKUPDIR
    ln -sf $DOTDIR/$file $HOME/$file
done
