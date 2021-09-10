#!/bin/bash
#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

ARR=()
ARR+=("Dictionary")
#ARR+=("Colorscheme")
ARR+=("Pirokit")
ARR+=("Ytfzf")
ARR+=("Lyrics")
ARR+=("Mitype")
ARR+=("Redyt")
ARR+=("Ambiant Music")
ARR+=("OBS-remote")
ARR+=("Reddit-wall")
ARR+=("Wallhaven-wall")
ARR+=("Change-wall")
ARR+=("Jupyter Lab")

CHOICE=$(printf '%s\n' "${ARR[@]}" | dmenu)

case $CHOICE in
  "Dictionary")
    ~/scripts/dmenu/dmenu-dict.sh ;;
#  "Colorscheme")
#    ~/scripts/dmenu/dmenu-wal-colorscheme.sh ;;
  "Pirokit")
    ~/.src/pirokit/pirokit ;;
  "Ytfzf")
    ~/.src/ytfzf/ytfzf -D ;;
  "Lyrics")
    ~/scripts/dmenu/dmenu-lyrics.sh;;
  "Mitype")
    ~/scripts/general/type-test.sh;;
  "Redyt")
    ~/.src/redyt/redyt ;;
  "Ambiant Music")
    ~/scripts/dmenu/dmenu-ambiant-music.sh ;;
  "obs-remote")
    ~/scripts/dmenu/dmenu-obs.sh ;;
  "Reddit-wall")
    ~/scripts/general/waldl.sh ;;
  "Wallhaven-wall")
    ~/scripts/dmenu/dmenu-wallget.sh ;;
  "Change-wall")
    ~/scripts/dmenu/dmenu-wal-change.sh ;;
  "Jupyter Lab")
    ~/scripts/dmenu/dmenu-jupyter-notebook.sh ;;
esac
