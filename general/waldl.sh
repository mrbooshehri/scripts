#! /bin/bash

mkdir -p /mnt/1TB/Pictures/wallpapers.reddit

wget -nc -P /mnt/1TB/Pictures/wallpapers.reddit $(curl -s -H "User-Agent: 'your bot 0.1'"  https://www.reddit.com/r/wallpaper/hot.json\?limit\=20 | jq --raw-output '.data.children[].data.url' | grep -Eoh 'https://.+.[jpg,png]$')





