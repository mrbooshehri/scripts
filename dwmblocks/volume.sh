#!/bin/bash

echo  $(amixer -c 1 -D pulse sget Master |grep 'Left:')| awk -F '[][]' '{print $2}'
#VOL=$(amixer -c 1 -D pulse sget Master |grep 'Left:')| awk -F '[][]' '{print $2}'
#STAT=$(amixer -c 1 -D pulse sget Master |grep 'Left:')| awk -F '[][]' '{print $4}'
#case $STAT in 
#  off)
#	echo "婢 ${VOL}"
#    ;;
#  on)
#	echo "墳 ${VOL}" 
#    ;;
#esac
