#
# X Windows startup file.
#
# Credit goes to: https://github.com/brandon-rhodes/homedir/blob/master/.xinitrc

# .xinitrc is exectued when you explicitly run xinit (startx ultimately calls xinit)
# to start an X-server. Mostly this doesn't happen as current Linuxes use desktop managers,
# which diretly start a X-Server and then run /etc/X11/Xsession <desktopenvironment>,
# where <desktopenvironment> is the value of any line Exec= from a file in /usr/share/xsessions,
# for instance

# /etc/X11/Xsession.d/40x11-common_xsessionrc
#   [~/.xsession]  Source user defined xsessionrc (locales and other environment variables)

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
  i3 | i3wm) /usr/bin/i3 ;;
  kde) exec startkde ;;
  xfce | xfce4) exec startxfce4 ;;
  mate) exec /usr/bin/mate-session ;;
  gnome) exec /usr/bin/gnome-session ;;
  # No known session, try to run it as command
  *) exec $1 ;;
esac

~/bin/flog -se "~/.xinitrc"
