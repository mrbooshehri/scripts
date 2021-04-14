#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

#! /bin/bash
dir_repo="/mnt/1TB/Pictures/Wallpaper.repo"
dir_tmp="/tmp/wallpaper"
maxpage=5

mkdir -p $dir_tmp

tagoptions="#4K\n#artwork\n#nature\n#fantasy art\n#technology\n#minimalism\nabstract"
if [ -z $1 ]; then
  query=$(echo -e $tagoptions | dmenu -p "Search wallhaven: ")
else
  query=$1
fi

#if [ -z $query ]; then
#  exit
#fi
[ -z $query ] && exit 1

sortoptions="date_added\nrelevance\nrandom\nfavorites\ntoplist"
sorting=$(echo -e $sortoptions | dmenu -p "Sort order: ")

query="$(sed 's/#//g' <<<$query)"
query="$(sed 's/ /+/g' <<<$query)"

notify-send "  Downloading..."
for i in $(seq 1 2);
do
  curl -s https://wallhaven.cc/api/v1/search\?atleast\=1920x1080\&sorting\=$sorting\&q\=$query\&page\=$i > tmp.txt
  #page=$(cat tmp.txt | jq '.' | grep -Eoh "https:\/\/w\.wallhaven.cc\/full\/.*(jpg|png)\b")
  page=$(cat tmp.txt | jq --raw-output '.data[].path')
  wget -qnc -P $dir_tmp $page
done

rm tmp.txt
notify-send "  All files downloaded"

sxiv -t $dir_tmp/*

mv $dir_tmp/* $dir_repo
notify-send "  Files moved"

