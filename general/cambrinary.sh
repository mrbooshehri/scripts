#! /bin/bash
word=$(dmenu -p "Dictonary search: " <&-)

[ -z "$word" ] && exit 1

# to remove color output use per
cambrinary -w "$word" | perl -pe 's/\e\[?.*?[\@-~]//g' | dmenu -l 15
