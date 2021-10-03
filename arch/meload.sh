#!/bin/bash

## variables
dir_home=$HOME
dir_src=$dir_home/.src
dir_dots=$dir_home/.dotfiles

## install base packages
printf 'Install packages...\n'
sudo pacman -S --noconfirm alacritty picom conky kdeconnect sxiv zathura mpv moc redshift sxhkd thunar virtualbox obs-studio code telegram-desktop torbrowser-launcher scrot lxappearance speedcrunch gedit firefox emacs bitwarden gimp youtube-dl zsh jq syncthing stow transmission-cli dunst polkit-gnome rofi neofetch nodejs
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

## install from AUR
printf 'Install packages from AUR...\n'
yay -S anydesk-bin safeeyes balena-etcher stremio xmenu betterlockscreen python-pywal otpclient pup #optimus-manager optimus-manager-qt
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
## persinal scripts
printf 'Cloning personal repos...\n'
git clone https://github.com/mrbooshehri/.dotfiles.git
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

## reload config files with stow
printf 'Restore all config files...\n'
cd "$dir_dots" 
stow -vt ~ $(ls -d */)
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

## xinit
#echo "exec dwm" > "$dir_home/.xinitrc"

## add x to bash
#echo "startx" >> "$dir_home/bashrc"

## useful tools
printf 'Cloning other repos...\n'
mkdir -p "$dir_src"
cd "$dir_src" || echo "Falied to change dirctory to $dir_src"
git clone https://github.com/pystardust/ytfzf.git
git clone https://github.com/Bugswriter/pirokit.git
git clone https://github.com/egeesin/alacritty-color-export.git
git clone https://github.com/GideonWolfe/Zathura-Pywal.git
git clone https://github.com/agnipau/telegram-palette-gen.git

# Install node packages
npm install -g spotify-dl
