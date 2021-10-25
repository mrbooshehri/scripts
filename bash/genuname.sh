#!/bin/bash
username=$(shuf ./usernames.txt | head -1)
number=$((1 + $RANDOM % 1000)) 

case $1 in
  "") echo ${username} ;;
  "-n") echo "${username}${number}" ;;
  "-sn") echo "${username}${number}" ;;
  "-h") echo "Simple username generator"
  	echo  -e "-h\thelp"
    	echo  -e "-n\tUsername with a random number at the end"
  	echo  -e "-sn\tUsername with a random number at the end separated with an underline"
    ;;
  *) echo "Error: Invalid argument."
    exit 1
    ;;
esac
