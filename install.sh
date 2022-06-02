#!/bin/bash

CPATH="$HOME/repos/termux-dotfiles"
for f in $CPATH/dotfiles/.*; do
	f=$(basename $f)
	echo $f
	file dotfiles/$f | grep directory -q && continue || ln -fs $CPATH/dotfiles/$f $HOME/$f
done
ln -fs $CPATH/scripts $HOME/scripts
