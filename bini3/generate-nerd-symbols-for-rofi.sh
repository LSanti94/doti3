#!/bin/bash
# This file will generate nerd-symbols.dat file which is the container for 
# selection entries of all available symbols in NerdFonts and can be used
# by rofi to be searched

set -ex
get_hex_cb(){
   local from=$(echo "ibase=16; $1"|bc)
   local to=$(echo "ibase=16; $2"|bc)
   local default=$3
   local str=" "
   for((i=from;i<=to;i++))
   do
      local hex=$(printf '%x' $i)
      local char=$(echo -e "\u$hex")
      if [[ "$char" = "$default" ]]; then
         char="^$char"
         notify-send "found" "ok"
      fi
      str="$str!$char"
   done
   echo $str
}

pars_file(){
   local f=$1
   local out=$2
   local count=0
   while read line; do
      key=$(echo $line | awk -F'[= ]' '{print $3}'| cut -c 3- | tr '_' ' ' )
      if [[ ! $line =~ (^\#|^test|^unset) ]] && [[ -n $key ]]; then
         char=$(echo $line | cut -c4-6)
         unicode=$(printf $char | iconv -f utf8 -t utf16 - | od -An -tx2 | sed 's/.*/\U&/; s/^ FEFF//; s/ /\\u/g')
         printf "\u200E<span color='white' background='black'> $char </span>\t<span color='yellow'>\\$unicode</span>\t<span color='LightYellow'>$key</span>\n" >> $out
      fi
      ((count++))
   done < "$f"
}

# assuming nerd-fonts source is installed in $HOME/git/nerd-fonts 
nerd_base=$(readlink -f ~/git/nerd-fonts/bin/scripts/lib)
out=$(readlink -f ~/bini3/nerd-symbols.dat)

truncate $out --size 0
# pars_file $nerd_base/i_dev.sh $out
# pars_file /home/existme/tmp/x.sh $out
for filename  in  $nerd_base/*.sh; do
   echo $filename
   pars_file $filename $out
done
cat $out |rmenu "select"
