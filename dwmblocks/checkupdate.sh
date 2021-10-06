#! /bin/bash

# for manjaro
#checkupdates | wc -l
# for arch
pacman -Qu | grep -Fcv "[ignored]"
