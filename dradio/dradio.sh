#!/bin/bash
for prog in dmenu mpv; do
	[ ! "$(which "$prog")" ] && echo "Please install $prog!" && exit 1
done

dir_home="${XDG_CONFIG_HOME:-$HOME/.config}/dradio"
[ ! -d "$dir_home" ] && mkdir -p "$dir_home"

[ ! -f "$dir_home/stations.txt" ] && cat > "$dir_home/stations.txt" << EOF
# You can radio staions .pls/.m3u here
#Station name		#URL
Tekno1			http://212.83.149.66:8591/listen.pls?sid=1&t=.m3u
Planet LoFi		http://198.245.60.88:8080/listen.pls?sid=1&t=.m3u
Ambient Modern		http://163.172.169.217:80/listen.pls?sid=1&t=.m3u
Kraftphunk		http://62.210.10.4:8096/listen.pls?sid=1&t=.m3u
AutoDJ lofi		http://119.235.255.206:8158/listen.pls?sid=1&t=.m3u
EOF

case $1 in
  "-p")
	choice=$(grep -v '^#' "$dir_home/stations.txt" | awk -F '\t' '{print $1}' | dmenu -l 15 -p "Radio stations: ")
	[ -z "$choice" ] && exit 1
	station_url=$(grep "$choice" "$dir_home/stations.txt" | awk -F '\t' '{print $(NF)}')
	notify-send "dradio" "[ $choice ] station is playing"
	mpv $station_url
	;;
  "-s") killall mpv ;;
  "-h") echo "-p	Play radio station"
	echo "-s	Stop mpv player"
    ;;
esac
