#!/bin/zsh
export BASE=$(git rev-parse --show-toplevel)

echo "Installing prerequisites for this configuration:\n"

# *************************************************************
# ************ xbindkeys and related utilities ****************
# *************************************************************

# xautomation: this will include xte which is used in xbindkeys configuration
# lockfile-progs:     this will install lockfile-remove etc, which is used in `pn` script for playing sounds
#                       or in i3-mousewheel for fast scrolling
# xdotool:            is used in some bindingings of xbindkeys
# xbindkeys:          for additional shortcut configuration
# numlockx:           for setting numlock state
# yad:                is used instead of zenity for dialog boxes such as rename window dialog
# cifs-utils:         for mounting remote file systems
# sxhkd:              sxhkd hotkey daemon
# dbus-user-session:  for dunst service working

sudo apt install -yf xautomation lockfile-progs \
                    xdotool xbindkeys xbindkeys-config numlockx \
                    yad \
                    arc-theme \
                    cifs-utils nfs-common  \
                    toilet pv \
                    sxhkd \
                    dbus-user-session


# See https://superuser.com/a/1128905/285113 for more information
# also: man systemd.service
sudo cp $BASE/services/sxhkd.service /usr/lib/systemd/user/
sudo cp $BASE/services/dunst.service /usr/lib/systemd/user/
sudo cp $BASE/services/xbindkeys.service /usr/lib/systemd/user/
sudo cp $BASE/services/compton.service /usr/lib/systemd/user/
sudo cp $BASE/services/i3-session.target /usr/lib/systemd/user/

sudo systemctl daemon-reload
systemctl --user daemon-reload

systemctl --user enable sxhkd
systemctl --user enable dunst
systemctl --user enable xbindkeys
systemctl --user enable compton

# when i3-session.target is restarted all dependant services should be restarted as well
systemctl --no-block --user restart i3-session.target

systemctl --user status i3-session.target

systemctl --user status sxhkd
systemctl --user status dunst
systemctl --user status xbindkeys
systemctl --user status compton
