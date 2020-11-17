#!/usr/bin/env /bin/zsh
alreadyRunning=`xdotool search --class "chrome" | wc -l`

# i3-subscribe should only have one instance and should be renewed on each restart
ps -fC perl | grep i3-subscribe | awk '{print $2}' | xargs kill
$HOME/bini3/i3-subscribe window &

if [ "$alreadyRunning" != "0" ]; then
   exit
fi
# export $(dbus-launch)
export BUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
~/.screenlayout/layout.sh
gnome-keyring-daemon
if [ "$1" = "-v" ]; then
   LOG='/tmp/i3-start.log'
   echo "Debug is enabled. logging to [$LOG]"
   user=$(whoami)
   sudo chown $user $LOG
   exec 3>&1 4>&2
   exec 1>>${LOG}
   exec 2>>${LOG}
elif [ -n "$1" ]; then
   echo $1
   echo "The only acceptable parameter is -v for enabling debug:\n"
   echo "   $ i3-startup -v"
   echo "\nor just\n"
   echo "   $ i3-startup"
   exit
fi
set -x

$HOME/bin/flog -st "i3-startup"

# Start the target service which loads all dependant services like dunst, sxhkd, ...
systemctl --no-block --user start i3-session.target

# use " &> /dev/null " to get rid of both errors and outputs of an exec
exec "$HOME/.dropbox-dist/dropboxd" &> /dev/null &

# this is network applet
killall nm-applet &> /dev/null
sudo /usr/bin/nm-applet &> /dev/null &

# exec "mate-settings-daemon" --replace &> /dev/null &

# to fix redshift error for geolocation edit `/etc/geoclue/geoclue.conf` add:
# [redshift]
#   allowed=true
#   system=false
#   users=
# also:
#  sudo apt-get remove geoclue*
#  sudo apt-get install geoclue-2.0
killall redshift &> /dev/null
killall redshift-gtk &> /dev/null

# $HOME/bini3/toggle-gaps set

killall albert &> /dev/null
exec "/usr/bin/albert" &> /dev/null &

#it's important that you distinguish between the command and its parameters
#Open in        $Workspace $WaitTime   $Command
W1=$(xgetres i3.w1)
W2=$(xgetres i3.w2)

# This is the result of i3-save layout
#     i3-msg rename workspace to 1
#     i3-save-tree --workspace 1 > browser.json
#
# don't forget that you should edit the file afterwards

if [ "$alreadyRunning" = "0" ]; then
   alert "We didn't found chrome instance so we restore the layout" "alreadyRunning=$alreadyRunning"
   i3-msg "workspace $W1; append_layout $HOME/bini3/layout/w1-browser.json"
   i3-msg "workspace $W2; append_layout $HOME/bini3/layout/w2-terminal.json"

   # $HOME/bini3/,ow 2          0           "/usr/bin/terminator"
   # $HOME/bini3/,ow 2          1           "/usr/bin/thunar" --daemon
   # $HOME/bini3/,ow 1          3           "/usr/bin/google-chrome" --force-device-scale-factor=1.25 &
   # $HOME/bini3/,ow 1          15          "redshift-gtk" &

   exec /usr/bin/tilix &
   exec /usr/bin/tilix &
   exec $HOME/bin/,chromium-video &
   exec code ~/notes.md &
   # $HOME/bin/flog "delay loading redshift"
   # (sleep 10 && exec redshift-gtk) &
else
   alert "passing..."
fi

exec "/usr/bin/thunar" --daemon &


exec "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox" --minimize &> /dev/null &
exec `which nitrogen` --restore &> /dev/null &
$HOME/bin/flog "nitrogen restored"

amixer -D pulse sset Master 60% > /dev/null
$HOME/bini3/,volume up # to show the current volume on i3bar
paplay ~/sounds/effects/UL_FS_Low_Boom_Var4.wav &

$HOME/bin/flog -se "i3-startup"
# experimental to fix delays when lunching Gnome apps (see http://bit.ly/35mdqvL )
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCKS


