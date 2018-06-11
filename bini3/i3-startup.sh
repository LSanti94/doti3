#!/usr/bin/env /bin/zsh
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
# use " &> /dev/null " to get rid of both errors and outputs of an exec
exec "/usr/bin/x-session-manager" &> /dev/null &
exec "$HOME/.dropbox-dist/dropboxd" &> /dev/null & 

# this is network applet
killall nm-applet &> /dev/null
exec "/usr/bin/nm-applet" &> /dev/null &

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
exec "redshift-gtk" &> /dev/null &

# $HOME/bini3/toggle-gaps set

killall albert &> /dev/null  
exec "/usr/bin/albert" &> /dev/null &

killall xbindkeys &> /dev/null  
exec "/usr/bin/xbindkeys" &> /dev/null &

killall compton &> /dev/null
compton --config ~/.config/compton.conf -b
#it's important that you distinguish between the command and its parameters
#Open in        $Workspace $WaitTime   $Command
$HOME/bini3/,ow 2          0           "/usr/bin/terminator" 
$HOME/bini3/,ow 2          1           "/usr/bin/thunar" --daemon
$HOME/bini3/,ow 1          3           "/usr/bin/google-chrome" --force-device-scale-factor=1.25 &

exec "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox" --minimize &> /dev/null &
exec `which nitrogen` --restore &> /dev/null &

amixer -D pulse sset Master 60% > /dev/null
$HOME/bini3/,volume up # to show the current volume on i3bar
paplay ~/sounds/milton__kualalumpur-international.wav &



