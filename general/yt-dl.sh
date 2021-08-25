#! /bin/env bash
if test -f "$1"; then
  printf "Downloading from file\n"
  while [ -s "$1" ];
  do
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
    link=$(head -1 "$1")
    printf "Downloading: %${link}\n"
    while ! youtube-dl "$link" -c --socket-timeout 5; do echo DISCONNECTED; sleep 5; done
    sed -i '1d' "$1" && echo "Line removed" || echo "Line didn't removed"
    printf "Done\n"
  done
else
  printf "Downloading from link\n"
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
  printf "Downloading: %s\n" "$1"
  while ! youtube-dl "$1" -c --socket-timeout 5; do echo DISCONNECTED; sleep 5; done
  printf "Done"
fi

