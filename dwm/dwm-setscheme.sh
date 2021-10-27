#! /usr/bin/env bash

themes=()
themes+=("dracula")
themes+=("gruvbox-dark")
themes+=("gruvbox-light")
themes+=("nord")
themes+=("solarized-dark")
themes+=("solarized-light")
isDark=1

choice=$(printf "%s\n" "${themes[@]}" | dmenu)
[ -z "$choice" ] && exit 1

case $choice in
  "dracula")
    wal --theme base16-dracula ;;
  "gruvbox-dark")
    wal --theme base16-gruvbox-medium ;;
  "gruvbox-light")
    wal --theme base16-gruvbox-medium -l 
    isDark=0 ;;
  "nord")
    wal --theme base16-nord;;
  "solarized-dark")
    wal --theme base16-solarized ;;
  "solarized-light")
    wal --theme base16-solarized -l
    isDark=0 ;;
   *)
    notify-send "Colorscheme" "Select valid colorscheme"
    exit
esac


# allacrity
bash ~/.src/alacritty-color-export/script.sh
ln -sf ~/.cache/wal/light_colors.yaml ~/.config/colorls
ln -sf ~/.cache/wal/dark_colors.yaml ~/.config/colorls

# zathura
bash ~/.src/Zathura-Pywal/install.sh

# telegram
bash ~/.src/telegram-palette-gen/telegram-palette-gen --wal

# xresources
cat ~/.cache/wal/xmenu >> ~/.cache/wal/colors.Xresources
ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources


## dunst
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
pkill dunst
dunst &

# gtk, kde and rofi theme
gtk_conf=~/.config/gtk-3.0/settings.ini
kde_conf=~/.config/Kvantum/kvantum.kvconfig

sed -i '/gtk-theme-name/d' $gtk_conf
sed -i '/gtk-icon-theme-name/d' $gtk_conf
sed -i '/theme/d' $kde_conf

case $isDark in
  0)
    echo "gtk-theme-name=Matcha-light-aliz" >> $gtk_conf
    echo "gtk-icon-theme-name=deepin" >> $gtk_conf
    echo "theme=Matchama-Light-Aliz" >> $kde_conf 
    ln -sf ~/.cache/wal/conkyrc_light ~/.conkyrc
    ln -sf ~/.cache/wal/rofi-light ~/.config/rofi/config.rasi
    ;;
  1)
    echo "gtk-theme-name=Matcha-dark-aliz" >> $gtk_conf 
    echo "gtk-icon-theme-name=deepin-dark" >> $gtk_conf
    echo "theme=Matchama-Dark-Aliz" >> $kde_conf
    ln -sf ~/.cache/wal/conkyrc_dark ~/.conkyrc
    ln -sf ~/.cache/wal/rofi-dark ~/.config/rofi/config.rasi
    ;;
esac

# reload xresources file
xrdb -load ~/.Xresources

# dwm
dwmc xrdb

## conky
pkill conky
conky &

# update forefox theme
~/.local/bin/pywalfox update

# send notification
notify-send "Colorscheme" "[ $choice ] colorscheme selected"

