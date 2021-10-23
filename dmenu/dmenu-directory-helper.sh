#! /bin/bash
choice=$(echo -e "/home\n/mnt" | dmenu -p "Select path: ")

[ -z "$choice" ] && exit 1

case $choice in
  "/home") select=$(find ~ -maxdepth 3 -type d 2>/dev/null | cut -d "/" -f 4- | tail -n +2 | sort | dmenu -l 15)
    dir_home=/home/mhmd
    ;;
  "/mnt") select=$(find /mnt/1TB/ -maxdepth 3 -type d 2>/dev/null | cut -d "/" -f 4- | tail -n +2 | sort | dmenu -l 15) 
    dir_home=/mnt/1TB
    ;;
esac

[ -z "$select" ] && exit 1

thunar "$dir_home/$select"
