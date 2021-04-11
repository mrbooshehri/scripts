#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

#! /bin/bash

# wallpaper repository and temp
dir_repo="/mnt/1TB/Pictures/wallpapers.reddit"
dir_tmp="/tmp/wallpaper"

mkdir -p $dir_repo
mkdir -p $dir_tmp

notify-send "    Downloading..."

wget -qnc -P $dir_tmp $(curl -s -H "User-Agent: 'your bot 0.1'"  https://www.reddit.com/r/wallpaper/hot.json\?limit\=20 | jq --raw-output '.data.children[].data.url' | grep -Eoh 'https://.+.[jpg,png]$')

notify-send "    All files downloaded"

sxiv -t $dir_tmp/*

mv $dir_tmp/* $dir_repo

notify-send "    Files moved"




