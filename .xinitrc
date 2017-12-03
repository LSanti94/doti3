#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
xrdb -load "$HOME/.Xdefaults"
xrdb -load "$HOME/.Xresources"
xrdb -load "$HOME/.XresourcesLocal"
xset +fp "$HOME/.fonts"
xset fp rehash
. /etc/X11/Xsession
