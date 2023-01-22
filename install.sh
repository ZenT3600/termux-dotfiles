#!/bin/bash

CPATH="$(dirname $0)"
find $CPATH/dotfiles/ -type f | while read f; do
	f=$(basename $f)
	echo $f
	ln -fs $CPATH/dotfiles/$f $HOME/$f
done
ln -dfs $CPATH/scripts $HOME/scripts
