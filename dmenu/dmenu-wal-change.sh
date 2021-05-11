#! /usr/bin/env bash
dir_repo=/mnt/1TB/Pictures/Wallpaper.repo
feh --bg-fill "$(find $dir_repo -regextype egrep -regex '.*.(jpg|png)' | shuf | head -1)"
