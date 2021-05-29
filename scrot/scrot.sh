#! /usr/bin/env bash

# swich		action
# 		entire screen
# -a		active window
# -s		selection mode

dir_repo=~/Pictures/screenshots

case $1 in 
  "-a") scrot $dir_repo/%Y-%m-%d_screenshot.png -u -q 100 \
  	-e 'xclip -selection clipboard -t image/png "$f"; \
   	notify-send -t 3000 "Scrot [ Active window ]" "Screenshot taken\n$n"' ;;

  "-s") sleep 0.1 && scrot $dir_repo/%Y-%m-%d_screenshot.png -f -l width=3 -s -q 100 \
      	-e 'xclip -selection clipboard -t image/png "$f"; \
      	notify-send -t 3000 "Scrot [ Selected area]" "Screenshot taken\n$n"';;

  *) scrot $dir_repo/%Y-%m-%d_screenshot.png -q 100 \
     -e 'notify-send -t 3000 "Scrot [ Entire screen ]" "Screenshot taken\n$n"' ;;

esac
