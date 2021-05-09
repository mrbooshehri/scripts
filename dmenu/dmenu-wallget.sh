#! /bin/bash
#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

# Check if necessary programs are installed
for prog in dmenu jq sxiv notify-send; do
	[ ! "$(which "$prog")" ] && echo "Please install $prog!" && exit 1
done

# Default directories
dir_conf="${XDG_CONFIG_HOME:-$HOME/.config}/wallget"
dir_repo="/mnt/1TB/Pictures/Wallpaper.repo"
dir_tmp="/tmp/wallpaper"

# API Key
api=9VxdYyf7irmZl8tIv6x6BSy7bylSKtUb

# Create .config/wallget if it does not exist to prevent
# the program from not functioning properly
[ ! -d "$dir_conf" ] && echo "Creating $dir_conf" && mkdir -p "$dir_conf"

## Sample tag
header="#Category\t\t\tTag"
default="Minimalism\t\t\t2278"

# If subbreddit.txt does not exist, create it to prevent
# the program from not functioning properly
[ ! -f "$dir_conf/config.txt" ] && echo -e "$header\n$default" >> "$dir_conf/config.txt"

# If no argument is passed
if [ -z "$1" ]; then
	# Ask the user to enter a subreddit
	query=$(tail -n +2 $dir_conf/config.txt | awk '{print $1}' | dmenu )
	# Fetch tag number from config file if it exists
	[ ! -z "$(grep $query $dir_conf/config.txt)" ] && $query=$(awk '/$query/ {print $2} $dir_conf/config.txt')
	# If nothing was chosen, exit
	[ -z "$query" ] && exit 1
else
	query="$1"
fi
echo $query

# Asking for sorting option
sortoptions="date_added\nrelevance\nrandom\nfavorites\ntoplist"
sorting=$(echo -e $sortoptions | dmenu -p "Sort order: ")
[ -z "$sorting" ] && exit 1

#           "Title"   "Message"
notify-send "Wallget" "  Downloading..."

for i in $(seq 1 5);
do
  curl -s https://wallhaven.cc/api/v1/search\?apikey\=$api\&atleast\=1920x1080\&sorting\=$sorting\&q\=$query\&page\=$i > tmp.txt
  page=$(cat tmp.txt | jq --raw-output '.data[].path')
  wget -nc -P $dir_tmp $page
done

notify-send "Wallget" "  All files have downloaded"
#
# Show downloaded files
sxiv -t $dir_tmp/*

# Remove temp files
rm tmp.txt
mv $dir_tmp/* $dir_repo

notify-send "Wallget" "  Files moved to $dir_repo"
