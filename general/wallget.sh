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
  wget -nc -P $dir_tmp $page
done

rm tmp.txt
notify-send "  All files downloaded"
sxiv -t $dir_tmp/*
mv $dir_tmp/* $dir_repo

