#!/bin/zsh
declare local DIR=$0:A:h:s/\/install//
function reLink(){
   # The physicalFolder link that is going to be symlinked
   declare local pFolder=$1
   local appFolder=$2
   local ppFolder=${pFolder//$appFolder/} # ~/bini3 -> ~/
   local linkedPath="$DIR/$2"
   if [[ -L "$pFolder" ]]; then
      echo " ${bW}${cZ} Removing ${bY}$pFolder${cZ} (It was symlink)"
      rm -i $pFolder
	else
      if [[ -a "$pFolder" ]]; then 
		   echo " ${bR}$pFolder${cZ} is not a symlink remove it manually"
         return 0
      fi
      # if file doesn't exists continue
	fi
   ln -s $linkedPath $ppFolder
   echo " ln -s ${bY}$linkedPath${bW}  ${bY}$ppFolder${cZ}  "
   echo
}
clear
echo "doti3 folder is ${bG}$DIR${cZ}\n"

reLink ~/.conkyrc          i3/conkyrc
# reLink ~/.xbindkeysrc.scm  .xbindkeysrc.scm
# reLink ~/.Xresources       .Xresources
# reLink ~/.XresourcesLocal  .XresourcesLocal
# reLink ~/.xinitrc          .xinitrc
# reLink ~/bini3 bini3
# reLink ~/.config/rofi rofi
# reLink ~/.config/terminator terminator
# reLink ~/.config/i3 i3
reLink ~/Downloads downloads
echo "\nRelink completed\n"
