#! /bin/bash
FILE=$(find ~/.config/* -mindepth 1 -maxdepth 2 | dmenu -l 15)
if [ -n "$FILE" ];then
	alacritty -e vim $FILE
fi
