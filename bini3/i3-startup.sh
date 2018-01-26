#!/bin/zsh
exec ./.dropbox-dist/dropboxd&
exec mate-settings-daemon --replace& 
exec redshift-gtk&
sleep 2
exec `which nitrogen` --restore

