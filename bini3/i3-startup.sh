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

exec "/usr/bin/nm-applet"&
exec "mate-settings-daemon" --replace &> /dev/null & 
killall redshift &> /dev/null  
exec "redshift-gtk" &> /dev/null &
$HOME/bini3/toggle-gaps set
exec "/usr/bin/albert" &> /dev/null &
exec `(which twmnd)` &
(
   sleep 2 && \
   exec "/usr/bin/google-chrome" -no-startup-window --force-device-scale-factor=1.25 &> /dev/null 
)&
(
   sleep 15 && \
   twmnc -c "nitrogen background restored" -i info && \
   exec `which nitrogen` --restore &> /dev/null 
)&
