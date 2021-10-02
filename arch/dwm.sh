#!/bin/bash

# Options
aur_helper=true
install_ly=false
install_lightdm=true
gen_xprofile=false

if [[ $aur_helper = true ]]; then
  cd /tmp
  git clone https://aur.archlinux.org/yay-git.git
  cd yay-git/;makepkg -si --noconfirm;cd
fi

# Install packages
sudo pacman -S xorg-xinit xorg-server xorg-xprop xorg-xsetroot xorg-xrandr xorg-xrdb xorg-xclipboard xorg-setxkbmap xorg-docs libxinerama libx11 webkit2gtk yajl mpd kitty 

if [[ $aur_helper = true ]]; then
  yay -Syyu 
  yay -S libxft-bgra lightdm-webkit-theme-aether 
fi

# Pull Git repositories and install
cd /tmp
repos=( "dmenu" "dwm" "dwmblocks" )
for repo in ${repos[@]}
do
  git clone "https://github.com/mrbooshehri/$repo.git"
  cd $repo;make;sudo make install;cd ..
done

# XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
  sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

# Install lightdm
if [[ $install_lightdm = true ]]; then
  sudo pacman -S lightdm lightdm-webkit2-greeter
  sudo systemctl enable lightdm 
fi

# Install ly
if [[ $install_ly = true ]]; then
  git clone https://aur.archlinux.org/ly
  cd ly;makepkg -si
  sudo systemctl enable ly
fi

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
