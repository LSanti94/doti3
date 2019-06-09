#!/bin/zsh
icon=dialog-information
ticon=" "
category="normal"
[ $3 ] && icon=$3
[ $4 ] && ticon="$4"
[ $5 ] && category=$5
if [[ $category = "normal" ]]; then  
   dunstify -p "$ticon $1" $2  -i $icon
else
   ID=$(cat /tmp/notify-$category)
   if [ -n "$ID" ]; then
      dunstify -p -r $ID "$1 $ticon" $2  -i $icon 
   else
      dunstify -p "$1 $ticon" $2  -i $icon > /tmp/notify-$category
   fi
fi

/usr/bin/xkbbell
