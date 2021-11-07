#!/bin/bash
url_pattern="https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)"
# Check requirement programs
for prog in dmenu mpv; do
	[ ! "$(which "$prog")" ] && echo "Please install $prog!" && exit 1
done

# Creating config directory
dir_home="${XDG_CONFIG_HOME:-$HOME/.config}/dradio"
[ ! -d "$dir_home" ] && mkdir -p "$dir_home"

# Create config file and put a sample in it
[ ! -f "$dir_home/stations.txt" ] && cat > "$dir_home/stations.txt" << EOF
# You can radio staions .pls/.m3u here
#Station name		#URL
Tekno1			http://212.83.149.66:8591/listen.pls?sid=1&t=.m3u
Planet LoFi		http://198.245.60.88:8080/listen.pls?sid=1&t=.m3u
Ambient Modern		http://163.172.169.217:80/listen.pls?sid=1&t=.m3u
Kraftphunk		http://62.210.10.4:8096/listen.pls?sid=1&t=.m3u
AutoDJ lofi		http://119.235.255.206:8158/listen.pls?sid=1&t=.m3u
EOF

# Functions
play(){
  nohup mpv $station_url --no-video 2&>/dev/null &
  if [ $1 == "dmenu" ];then
    [[ $? -eq 0 ]] && notify-send "dradio" "[ $choice ] station is playing" || notify-send "dradio" "Error in playing with mpv"
    elif [ $1 == "fzf" ];then
    [[ $? -eq 0 ]] && echo "[ $choice ] station is playing." || echo "Error in playing with mpv."
  fi
}

case $1 in
  "-d"|"--dmenu")
    	# List stations from ~/.config/dradio/stations.txt in dmenu and play the selected one in mpv
	choice=$(grep -v '^#' "$dir_home/stations.txt" | awk -F '\t' '{print $1}' | dmenu -l 15 -p "Radio stations: ")
	[ -z "$choice" ] && exit 1
	station_url=$(grep "$choice" "$dir_home/stations.txt" | awk -F '\t' '{print $(NF)}')
	nohup mpv $station_url --no-video 2&>/dev/null &
	play dmenu
  ;;
  	# Stop playing 
  "-s"|"--stop") 
  	killall mpv 2&>/dev/null ;;
    	# List stations from ~/.config/dradio/stations.txt in fzf and play the selected one in mpv
  "-f"|"--fzf")	
  	choice=$(grep -v '^#' "$dir_home/stations.txt" | awk -F '\t' '{print $1}' | fzf)
	[ -z "$choice" ] && exit 1
	station_url=$(grep "$choice" "$dir_home/stations.txt" | awk -F '\t' '{print $(NF)}')
	nohup mpv $station_url --no-video 2&>/dev/null &
	play fzf
  ;;
  	# Show the list of stations in ~/.config/dradio/stations.txt
  "-l"|"--list") 
  	less $dir_home/stations.txt ;;
  	# Add new station
  "-a"|"--add") 
  	echo "Enter station name: "
    	read name
	echo "Enter station URL: "
    	read url
	echo -e "$name\t\t$url" >> $dir_home/stations.txt
  ;;
  	# Remove existing stations
  "-r"|"--remove") 
  	station=$(cat $dir_home/stations.txt | fzf | awk -F '\t' '{print $1}')
	[ -z "$station" ] && exit 1
    	line=$(grep -n $station $dir_home/stations.txt | cut -d ':' -f 1)
    	sed -i "${line}d" $dir_home/stations.txt &2> /dev/null
  ;;
"-u"|"--url") 
	[[ $2 =~ $url_pattern ]] && echo "it is ok" || echo "see help"
  ;;
  "-h"|"--help"|*) 
    	echo "-l, --list	List of radio staions"
        echo "-d, --delete	Show stations list in dmenu"
 	echo "-f, --fzf		Show stations list in fzf"
	echo "-s, --stop	Stop mpv player"
	echo "-a, --add 	Add staion"
	echo "-r, --remove	Remove station"
	echo "-h, --help	Show help"
  ;;
esac
