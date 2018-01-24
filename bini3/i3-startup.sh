#!/bin/zsh
exec ./.dropbox-dist/dropboxd&
exec mate-settings-daemon --replace& 
sleep 2
exec `which nitrogen` --restore
