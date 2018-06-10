#!/bin/zsh

echo "Installing prerequisites for this configuration:\n"

# *************************************************************
# ************ xbindkeys and related utilities ****************
# *************************************************************

# this will include xte which is used in xbindkeys configuration
sudo apt install xautomation 
# this will install lockfile-remove etc, which is used in `pn` script for playing sounds
# or in i3-mousewheel for fast scrolling
sudo apt install lockfile-progs
# xdotool is used in some bindingings of xbindkeys
sudo apt install xdotool
# xbindkeys for additional shortcut configuration
sudo apt install xbindkeys xbindkeys_config
# for setting numlock state
sudo apt install numlockx


# For mounting remote file systems
sudo apt install nfs-common cifs-utils
