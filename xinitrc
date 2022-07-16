#!/bin/sh

xrdb ~/.Xresources
if [ -e "$HOME/.Xmodmap" ]; then
	xmodmap "$HOME/.Xmodmap"
fi
exec i3
