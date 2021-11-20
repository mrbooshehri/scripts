#!/bin/bash
mpv_arg=https://youtube.com/playlist?list=

play(){
  stop
  if [ ! -z $1 ];then 
    nohup mpv --title=ytplp --shuffle --stop-playback-on-init-failure --no-video --input-ipc-server=/tmp/mpvsocket "$mpv_arg$1" 2&>/dev/null & 
    notify-send "MPV-ytp" "Playlist going to play"
  else
    notify-send "MPV-ytp" "Failed to play"
  fi
}

stop(){
  psid=$(ps aux | grep "\-\-title=ytplp" | awk '{print $2}')
  [ ! -z "$psid" ] && kill "$psid"
}
  pause(){
  echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket &> /dev/null
}

while getopts "tpsh?" opt
do
  case "$opt" in
    s) COMMAND=stop ;;
    p) COMMAND=play ;;
    t) COMMAND=pause;;
  esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

case "$COMMAND" in 
  play) play $1 ;;
  stop) stop ;;
  pause) pause ;;
esac
