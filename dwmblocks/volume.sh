#!/bin/bash

VOL=$(amixer -c 1 -D pulse sget Master | grep 'Left:' | awk -F '[][]' '{print $2}')
STAT=$(amixer -c 1 -D pulse sget Master | grep 'Left:' | awk -F '[][]' '{print $4}')
case $STAT in 
  off)
	echo " ${VOL}"
    ;;
  on)
    if [ $VOL == "0%" ]
    then
	echo " ${VOL}" 
    else
	echo " ${VOL}" 
    fi
    ;;
esac
