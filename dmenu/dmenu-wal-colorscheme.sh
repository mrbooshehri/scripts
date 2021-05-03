#                _                     _          _          _ 
#               | |                   | |        | |        (_)
# _ __ ___  _ __| |__   ___   ___  ___| |__   ___| |__  _ __ _ 
#| '_ ` _ \| '__| '_ \ / _ \ / _ \/ __| '_ \ / _ \ '_ \| '__| |
#| | | | | | |  | |_) | (_) | (_) \__ \ | | |  __/ | | | |  | |
#|_| |_| |_|_|  |_.__/ \___/ \___/|___/_| |_|\___|_| |_|_|  |_|

#! /bin/bash

wallpaper_repo=/mnt/1TB/Pictures/Wallpaper.repo
menu_items='Random\nDark\nLight'
choice=$(printf $menu_items | dmenu -p "Colorscheme: ")
isDark=0

case $choice in 
  Random)
    menu_items='No\nYes'
    choice=$(printf $menu_items | dmenu -p 'Do you want to change wallpaper too? ')
    case $choice in
      No)
    	menu_items='Dark\nLight'
    	choice=$(printf $menu_items | dmenu -p 'Select mode: ')
	case $choice in
	  Dark) wal --theme random_dark
	    	isDark=1;;
	  Light) wal --theme random_light 
	    	isDark=0;;
	  *) exit 1;;
	esac
	;;
      Yes) wal -i $wallpaper_repo/$(ls $wallpaper_repo | shuf | head -1)
	   isDark=0 ;;
      *) exit 1
    ;;
    esac
    ;;
  Dark)
    menu_items='3024\nashes\napathy\ngruvbox\nflat\ndracula\nsolarized'
    choice=$(printf $menu_items | dmenu -p 'Dark schemes: ')
    case $choice in 
      3024) wal --theme 3024;;
      ashes) wal --theme ashes;;
      gruvbox) wal --theme base16-gruvbox-hard	;;
      apathy | flat | dracula | solarized) wal --theme base16-$choice ;;
      *) exit 1
    esac
    isDark=1
    ;;
  Light) 
    menu_items='one\ngruvbox\nsolarized\nmexico\ntomorrow'
    choice=$(printf $menu_items | dmenu -p 'Light schemes: ')
    case $choice in 
      one | solarized | mexico | tomorrow) wal --theme base16-$choice -l ;;
      gruvbox) wal --theme base16-gruvbox-soft -l ;;
      *) exit 1
    esac
    isDark=0
    ;;
  *) exit 1
    ;;
esac

## intialization
dwmc xrdb
bash ~/.src/alacritty-color-export/script.sh
bash ~/.src/Zathura-Pywal/install.sh
bash ~/.src/telegram-palette-gen/telegram-palette-gen --wal
ln -sf ~/.cache/wal/config.rasi ~/.config/rofi/config
ln -sf ~/.cache/wal/Xresources  ~/.Xresources
ln -sf ~/.cache/wal/light_colors.yaml ~/.config/colorls
ln -sf ~/.cache/wal/dark_colors.yaml ~/.config/colorls

## conky
if [ $isDark == 1 ]; then
  ln -sf ~/.cache/wal/conkyrc_dark ~/.conkyrc
else
  ln -sf ~/.cache/wal/conkyrc_light ~/.conkyrc
fi
pkill conky
conky &

## dunst
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
pkill dunst
dunst &

# gtk theme 
file_conf=~/.config/gtk-3.0/settings.ini

sed -i '/gtk-theme-name/d' $file_conf
sed -i '/gtk-icon-theme-name/d' $file_conf

case $isDark in
  0)
    echo "gtk-theme-name=Matcha-light-aliz" >> $file_conf
    echo "gtk-icon-theme-name=deepin" >> $file_conf
    ;;
  1)
    echo "gtk-theme-name=Matcha-dark-aliz" >> $file_conf 
    echo "gtk-icon-theme-name=deepin-dark" >> $file_conf
    ;;
esac

# kde theme
file_conf=~/.config/Kvantum/kvantum.kvconfig

sed -i '/theme/d' $file_conf

case $isDark in
  0)
    echo "theme=Matchama-Light-Aliz" >> $file_conf 
    ;;
  1)
    echo "theme=Matchama-Dark-Aliz" >> $file_conf
    ;;
esac
