#!/bin/zsh
icon=dialog-information
ticon="<span color='#FFFFFF' weight='heavy'> </span>"
category="normal"
[ $3 ] && icon=$3
[ $4 ] && ticon="<span color='#FFFFFF' weight='heavy'>$4</span>"
[ $5 ] && category=$5
if [[ $category = "normal" ]]; then  
   dunstify -p "$ticon<span color='#FBCA31' weight='heavy'>$1</span>" $2  -i $icon
else
   ID=$(cat /tmp/notify-$category)
   if [ $ID ]; then
      dunstify -p "$ticon<span color='#FBCA31' weight='heavy'>$1</span>" $2  -i $icon > /tmp/notify-$category
   else
      dunstify -p -r $ID "$ticon<span color='#FBCA31' weight='heavy'>$1</span>" $2  -i $icon > /tmp/notify-$category
   fi
fi

/usr/bin/xkbbell
