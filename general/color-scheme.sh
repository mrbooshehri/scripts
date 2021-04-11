#! /bin/bash
wal -i /mnt/1TB/Pictures/Wallpaper.repo/$(ls /mnt/1TB/Pictures/Wallpaper.repo | shuf | head -1)

## intialization
dwmc xrdb
bash ~/github/alacritty-color-export/script.sh
bash ~/github/Zathura-Pywal/install.sh
bash ~/github/telegram-palette-gen/telegram-palette-gen --wal
ln -sf ~/.cache/wal/config.rasi ~/.config/rofi/config
ln -sf ~/.cache/wal/Xresources  ~/.Xresources

## dunst
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
pkill dunst
dunst &
