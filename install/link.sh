#!/bin/zsh
show_help(){
   echo "usage:\n"
   echo "${bY}--help${cZ}     Show this page"
   echo "${bY}--s${cZ}        Skip saying yes for removing symlinks"
   echo
}
if [ "$1" = "--s" ]; then
   skip=1
elif [ "$1" = "--help" ]; then
   show_help
   exit 0
elif [ $# -ne 0 ]; then
   show_help
   exit 1
fi

# See http://wiki.bash-hackers.org/scripting/terminalcodes
green=$(printf '\x1b[38;2;%s;%s;%sm' 20 220 20)

declare local DIR=$0:A:h:s/\/install//
function reLink(){
   # The physicalFolder link that is going to be symlinked
   declare local pFolder=$1               #
   local appFolder=$2                     #
   [ "$3" = "true" ] && useSudo="sudo" || useSudo=""


   # Note: if you are linking folder this means that
   # Todo: fix this because $ relink ~/.mutt mutt will fail
   local ppFolder=${pFolder//$appFolder/} # ~/bini3 -> ~/
   local linkedPath="$DIR/$2"

   if [[ -L "$pFolder" ]]; then
      echo " ${bW}${cZ} Removing ${bY}$pFolder${cZ} (It was symlink)"
      if [ "$skip" = 1 ]; then
         $useSudo rm $pFolder
      else
         echo -n "  "
         $useSudo rm -i $pFolder
      fi
	else
      if [[ -a "$pFolder" ]]; then
		   echo "${bR} ${cZ} Folder [${bR}$pFolder${cZ}] is not a symlink remove it manually"
         echo ""
         return 0
      fi
      # if file doesn't exists continue
	fi
   # exec 3>&1 4>&2 #set up extra file descriptors
   # error=$( { ln -s $linkedPath $ppFolder | sed 's/Output/Useless/' 2>&4 1>&3; } 2>&1 )


   [ -e /tmp/install_error ] && rm /tmp/install_error
   # echo "$useSudo ln -s $linkedPath $ppFolder"
   $useSudo ln -s "$linkedPath" "$ppFolder" 2> /tmp/install_error
   error=$(</tmp/install_error)

   [ "$error" = "" ] && echo "$green  ${cZ}ln -s ${bY}$linkedPath${bW}  ${bY}$ppFolder${cZ}  " || \
      echo "${bR} ${cZ} link failed [$error]"
   echo

   # exec 3>&- 4>&- # release the extra file descriptors
}
clear
echo "doti3 folder is ${bG}$DIR${cZ}\n"

reLink $HOME/.conkyrc                         i3/conkyrc
reLink $HOME/.xbindkeysrc.scm                 .xbindkeysrc.scm
reLink $HOME/.Xresources                      .Xresources
reLink $HOME/.XresourcesLocal                 .XresourcesLocal
reLink $HOME/.xinitrc                         .xinitrc
reLink $HOME/.i3blocks.conf                   i3/i3blocks.conf
reLink $HOME/bini3                            bini3
reLink $HOME/.config/compton.conf             i3/compton.conf
reLink $HOME/.config/rofi                     rofi
reLink $HOME/.config/terminator               terminator
reLink $HOME/.config/i3                       i3
reLink $HOME/.config/dunst/dunstrc            dunstrc
reLink $HOME/.config/geany                    geany
reLink $HOME/.config/mpv                      mpv
reLink $HOME/.config/ranger                   ranger
reLink $HOME/.weechat                         .weechat
reLink $HOME/.config/profanity                profanity
reLink $HOME/.config/bumblebee-status         bumblebee-status
reLink $HOME/.config/bumblebee-status.conf    bumblebee-status/bumblebee-status.conf
reLink $HOME/.config/doublecmd                doublecmd
reLink $HOME/.config/Code/User                vscode/User
reLink $HOME/.config/zathura/zathurarc        zathurarc
reLink $HOME/.config/QuiteRss/QuiteRss.ini    quiterss/QuiteRss.ini
reLink $HOME/.gcalclirc                       .gcalclirc
reLink $HOME/.mutt                            .mutt
reLink $HOME/.muttrc                          .mutt/muttrc

reLink /usr/share/icons/ext-icons             bini3/ext-icons true

echo "\nRelink completed\n"
