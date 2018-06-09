#
# X Windows startup file.
#
# Credit goes to: https://github.com/brandon-rhodes/homedir/blob/master/.xinitrc

# Execute the real startup file with bash.
~/bin/flog -st "~/.xinitrc"
. $HOME/.xinitrc2 || true
exec /usr/bin/i3 
~/bin/flog -se "~/.xinitrc"
