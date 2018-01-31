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
   local ppFolder=${pFolder//$appFolder/} # ~/bini3 -> ~/
   local linkedPath="$DIR/$2"
   if [[ -L "$pFolder" ]]; then
      echo " ${bW}${cZ} Removing ${bY}$pFolder${cZ} (It was symlink)"
      if [ "$skip" = 1 ]; then
         rm $pFolder
      else
         echo -n "  "
         rm -i $pFolder
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
   ln -s $linkedPath $ppFolder 2> /tmp/install_error
   error=$(</tmp/install_error)
   [ "$error" = "" ] && echo "$green  ${cZ}ln -s ${bY}$linkedPath${bW}  ${bY}$ppFolder${cZ}  " || \
      echo "${bR} ${cZ} link failed [$error]"
   echo

   # exec 3>&- 4>&- # release the extra file descriptors
}
clear
echo "doti3 folder is ${bG}$DIR${cZ}\n"

reLink ~/.conkyrc                i3/conkyrc
reLink ~/.xbindkeysrc.scm        .xbindkeysrc.scm
reLink ~/.Xresources             .Xresources
reLink ~/.XresourcesLocal        .XresourcesLocal
reLink ~/.xinitrc                .xinitrc
reLink ~/bini3                   bini3
reLink ~/.config/rofi            rofi
reLink ~/.config/terminator      terminator
reLink ~/.config/i3              i3
reLink ~/.config/dunst/dunstrc   dunstrc
reLink ~/.config/geany           geany
reLink ~/.weechat                .weechat 
reLink ~/.config/profanity       profanity
reLink ~/.config/Code/User       vscode/User

echo "\nRelink completed\n"
