#
# X Windows startup file.
#
# Credit goes to: https://github.com/brandon-rhodes/homedir/blob/master/.xinitrc

# Execute the real startup file with bash.
~/bin/flog -st "~/.xinitrc"
~/bin/flog "Session=$1"
session=${1:-i3}
(. $HOME/.xinitrc2) || true
~/bin/flog "Session:$1"
~/bin/flog "DISPLAY=$DISPLAY"
~/bin/flog "XDG_VTNR=$XDG_VTNR"
# exec /usr/bin/i3 

case $session in
    i3|i3wm           ) /usr/bin/i3;;
    kde               ) exec startkde;;
    xfce|xfce4        ) exec startxfce4;;
    mate              ) exec /usr/bin/mate-session;;
    gnome             ) exec /usr/bin/gnome-session;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac

~/bin/flog -se "~/.xinitrc"
