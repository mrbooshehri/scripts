#!/usr/bin/env bash

# name		icon
# volume		
# mute 		

#for puleaudio
#vol=$(amixer -c 1 -D pulse sget Master | grep '%' | head -1 | cut -d '[' -f 2 | cut -d '%' -f 1)
#mute=$(amixer -c 1 -D pulse sget Master | grep '%' | head -1 | awk -F '[][]' '{print $4}')
#for pipwire
vol=$(pamixer --get-volume)
mute=$(pamixer --get-mute)
icon=""

# for pulseaudio
#if [ "$mute" != "on" ] ;then
# for pipwire
if [ "$mute" != "false" ] ;then
  icon=""
fi

~/scripts/dunst/notify-send.sh -r  "$(pgrep dunst)" "$icon  $vol"

