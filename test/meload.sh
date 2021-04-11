#!/bin/bash

## variables
dir_home=$HOME
dir_src=$dir_home/.src
dir_suckless=dir_src/suckless

## update system
sudo pacman -Syyu

## install base packages
sudo pacman -S base-devel libx11 libxinerama yay vim git alacritty picom conky bluez network-manager-applet kdeconnect sxiv zathura mpv moc redshift sxhkd thunar virtualbox obs-studio code telegram-desktop torbrowser-launcher scrot neomutt inkscape lxappearance speedcrunch gedit vlc uget firefox emacs bitwarden audacity gimp youtube-dl optimus-manager zsh jq pup syncthing curl stow transmission-cli

## update AUR packages
yay -Syu

## install from AUR
yay -S artha anydesk-bin rambox safeeyes balena-etcher libxft-bgra lightdm-webkit-theme-aether stremio optimus-manager-qt xmenu betterlockscreen python-pywal 

## persinal scripts
git clone https://github.com/mrbooshehri/scripts.git
git clone https://github.com/mrbooshehri/.dotfiles.git

## useful tools
mkdir -p $dir_src
git clone https://github.com/pystardust/ytfzf.git $dir_src
git clone https://github.com/Bugswriter/pirokit.git $dir_src
git clone https://github.com/egeesin/alacritty-color-export.git $dir_src
git clone https://github.com/GideonWolfe/Zathura-Pywal.git $dir_src
git clone https://github.com/agnipau/telegram-palette-gen.git $dir_src

## suckless setup
mkdir -p $dir_suckless
git clone https://github.com/mrbooshehri/dwm.git $dir_suckless
git clone https://github.com/mrbooshehri/dmenu.git $dir_suckless
git clone https://github.com/mrbooshehri/st.git $dir_suckless
git clone https://github.com/mrbooshehri/dwmblocks.git $dir_suckless

## install dwm
cd $dir_suckless/dwm
sudo make clean install

## install dmenu
cd $dir_suckless/dmenu
sudo make install

## install st
cd $dir_suckless/st
sudo make clean install

## install dwmblocks
cd $dir_suckless/dwmblocks
sudo make clean install

## install oh-my-zh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## install zsh plugins
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
