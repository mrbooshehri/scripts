#!/bin/bash

## variables
dir_home=$HOME
dir_src=$dir_home/.src
dir_dots=$dir_home/.dotfiles

## update system
sudo pacman -Syyu --noconfirm
 
#Installing Driver and related utilites
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

## install base packages
sudo pacman -S --noconfirm alacritty picom conky kdeconnect sxiv zathura mpv moc redshift sxhkd thunar virtualbox obs-studio code telegram-desktop torbrowser-launcher scrot lxappearance speedcrunch gedit firefox emacs bitwarden gimp youtube-dl optimus-manager zsh jq pup syncthing curl stow transmission-cli dunst polkit-gnome mpd

## update AUR packages
yay -Syu

## install from AUR
yay -S anydesk-bin safeeyes balena-etcher stremio optimus-manager-qt xmenu betterlockscreen python-pywal otpclient

## persinal scripts
git clone https://github.com/mrbooshehri/scripts.git
git clone https://github.com/mrbooshehri/.dotfiles.git

## reload config files with stow
cd "$dir_dots" || return
stow --adopt -vt ~ * 

## xinit
#echo "exec dwm" > "$dir_home/.xinitrc"

## add x to bash
#echo "startx" >> "$dir_home/bashrc"

## useful tools
mkdir -p "$dir_src"
git clone https://github.com/pystardust/ytfzf.git "$dir_src"
git clone https://github.com/Bugswriter/pirokit.git "$dir_src"
git clone https://github.com/egeesin/alacritty-color-export.git "$dir_src"
git clone https://github.com/GideonWolfe/Zathura-Pywal.git "$dir_src"
git clone https://github.com/agnipau/telegram-palette-gen.git "$dir_src"
