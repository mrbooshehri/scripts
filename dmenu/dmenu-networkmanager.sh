#! /bin/bash

# Show network list
CHOICE=$(nmcli dev wifi list | tail -n +2 | cut -d '*' -f2 |  awk '{print " [ ",$2," ] ", " [ ",$8," ] "}' | dmenu -l 15 -p "Select your network: ")
[ -z "$CHOICE" ] && exit 0
IFACE=$(echo $CHOICE | awk '{print $2}')
# Get password
PASSWORD=$(dmenu -p "Enter [ $IFACE ] password : " <&-)
[ -z "$PASSWORD" ] && exit 0

# Connect to the network
RESPONS=$(nmcli dev wifi connect "$IFACE" password "$PASSWORD")

echo $RESPONS

