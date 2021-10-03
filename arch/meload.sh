#!/bin/bash

## variables
dir_home=$HOME
dir_src=$dir_home/.src
dir_dots=$dir_home/.dotfiles

## install base packages
sudo pacman -S --noconfirm alacritty picom conky kdeconnect sxiv zathura mpv moc redshift sxhkd thunar virtualbox obs-studio code telegram-desktop torbrowser-launcher scrot lxappearance speedcrunch gedit firefox emacs bitwarden gimp youtube-dl zsh jq syncthing stow transmission-cli dunst polkit-gnome 

## update AUR packages
yay -Syu

## install from AUR
yay -S anydesk-bin safeeyes balena-etcher stremio xmenu betterlockscreen python-pywal otpclient pup #optimus-manager optimus-manager-qt

## persinal scripts
git clone https://github.com/mrbooshehri/.dotfiles.git

## reload config files with stow
cd "$dir_dots" || echo "Falied to change dirctory to $dir_dots"
stow --adopt -vt ~ * 

## xinit
#echo "exec dwm" > "$dir_home/.xinitrc"

## add x to bash
#echo "startx" >> "$dir_home/bashrc"

## useful tools
mkdir -p "$dir_src"
cd "$dir_src" || echo "Falied to change dirctory to $dir_src"
git clone https://github.com/pystardust/ytfzf.git
git clone https://github.com/Bugswriter/pirokit.git
git clone https://github.com/egeesin/alacritty-color-export.git
git clone https://github.com/GideonWolfe/Zathura-Pywal.git
git clone https://github.com/agnipau/telegram-palette-gen.git
