#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

#! /bin/bash

# wallpaper repository and temp
dir_repo="/mnt/1TB/Pictures/Wallpaper.repo"
dir_tmp="/tmp/wallpaper"

mkdir -p $dir_repo
mkdir -p $dir_tmp

subreddit=$(echo -e "wallpaper\nwallpapers\nMinimalWallpaper\nportraits" | dmenu -p "Select subreddit: ")
[ -z "$subreddit" ] && exit 1

sort_option=$(echo -e "hot\nnew\ntop" | dmenu -p "Sort option: ")
[ -z "$sort_option" ] && exit 1

notify-send "Waldl" "  Downloading..."

wget -qnc -P $dir_tmp $(curl -s -H "User-Agent: 'your bot 0.1'"  https://www.reddit.com/r/$subreddit/$sort_option.json\?limit\=50 | jq --raw-output '.data.children[].data.url' | grep -Eoh 'https://.+.[jpg,png]$')

notify-send "Waldl" "  All files have downloaded"

find $dir_tmp \! -iname '*.jpg' -delete

sxiv -t $dir_tmp/*

if [ "$(ls $dir_tmp | wc -l)" -ne "0" ];then
  mv $dir_tmp/* $dir_repo
  notify-send "Waldl" "  Files moved"
else
 notify-send "  There is no file to move!"
fi



