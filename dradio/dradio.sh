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
  "-d")
	choice=$(grep -v '^#' "$dir_home/stations.txt" | awk -F '\t' '{print $1}' | dmenu -l 15 -p "Radio stations: ")
	[ -z "$choice" ] && exit 1
	station_url=$(grep "$choice" "$dir_home/stations.txt" | awk -F '\t' '{print $(NF)}')
	nohup mpv $station_url 2&>/dev/null &
	if [ $? -eq 0 ];then
	  notify-send "dradio" "[ $choice ] station is playing"
	else
	  notify-send "dradio" "Error in playing with mpv"
	fi
	;;
  "-s") killall mpv 2&>/dev/null ;;
  "-f")	choice=$(grep -v '^#' "$dir_home/stations.txt" | awk -F '\t' '{print $1}' | fzf)
	[ -z "$choice" ] && exit 1
	station_url=$(grep "$choice" "$dir_home/stations.txt" | awk -F '\t' '{print $(NF)}')
	nohup mpv $station_url 2&>/dev/null &
	if [ ! $? -eq 0 ];then
	 echo "Error in playing with mpv"
	fi
  	;;
  "-l") less $dir_home/stations.txt ;;
  "-a") echo "Enter station name: "
    	read name
	echo "Enter station URL: "
    	read url
	echo -e "$name\t\t$url" >> $dir_home/stations.txt
  ;;
  "-r") station=$(cat $dir_home/stations.txt | fzf | awk -F '\t' '{print $1}')
    	sed -i "/${station}/d" $dir_home/stations.txt &2> /dev/null
  ;;
  "-h"|*) echo "-l	List of radio staions"
        echo "-d	Show stations list in dmenu"
 	echo "-f	Show stations list in fzf"
	echo "-s	Stop mpv player"
	echo "-a	Add staion"
	echo "-r	Remove station"
    	;;
esac
