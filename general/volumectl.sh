#! /bin/bash
maxvol=100
vol=$(amixer -c 1 -D pulse sget Master | grep 'Left:' | awk -F '[][]' '{print $2}' | cut -d% -f1)

case $1 in
  -u)
    if [ $vol -lt $maxvol ];then  
      pactl set-sink-volume 0 +5%
    fi
    ;;
  -d) pactl set-sink-volume 0 -5% ;;
esac
