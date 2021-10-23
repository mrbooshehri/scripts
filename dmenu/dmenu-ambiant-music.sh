#! /usr/bin/env bash
gnr=()
gnr+=("Lofi")
gnr+=("Ocean")
gnr+=("Piano")
gnr+=("Rain")
gnr+=("Rap")
gnr+=("Relaxing")
gnr+=("Tibetian Bowl")

choice=$(printf "Play\nStop" | dmenu -p "Ambiant Music:")

case $choice in 
  "Play")
    link=$(printf '%s\n' "${gnr[@]}" | dmenu)
    case $link in 
      "Lofi")
	notify-send "Ambiant Music" "[ Lofi ] selected and will play soon"
	mpv https://www.youtube.com/watch?v=5qap5aO4i9A --no-video ;;
      "Relaxing")
	notify-send "Ambiant Music" "[ Relaxing ] selected and will play soon"
	mpv https://www.youtube.com/watch?v=uYZSDsdY9Zs --no-video ;;
      "Rain")
	notify-send "Ambiant Music" "[ Rap ]selected and will play soon"
	mpv https://www.youtube.com/watch?v=6Jrj7uIcfd4 --no-video ;;
      "Ocean")
	notify-send "Ambiant Music" "[ Rap ]selected and will play soon"
	mpv https://www.youtube.com/watch?v=rZ7VVGvrfiA --no-video ;;
      "Rap")
	notify-send "Ambiant Music" "[ Rap ]selected and will play soon"
	mpv https://www.youtube.com/watch?v=n4pr7j-kTO0 --no-video ;;
      "Piano")
	notify-send "Ambiant Music" "[ Piano ]selected and will play soon"
	mpv https://www.youtube.com/watch?v=XULUBg_ZcAU --no-video ;;
      "Tibetian Bowl")
	notify-send "Ambiant Music" "[ Tibetian Bowl ]selected and will play soon"
	mpv https://www.youtube.com/watch?v=Y6QTdvbu0uI --no-video ;; 
    esac ;;
   "Stop")
     killall mpv ;;
esac

