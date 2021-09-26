#! /usr/bin/env	bash
# Varaibles
dir_conf=~/.config/firefox-helper
file_bookmarks=$dir_conf/firefox-bookmarks

# Chechk conf folder and bookmark
mkdir -p $dir_conf
test -f $file_bookmarks || touch file_bookmarks

# Sort bookmarks file
printf "%s\n" "$(sort $file_bookmarks)" > $file_bookmarks

# Get input
input=$(dmenu -p "Go: " -l 5 < $file_bookmarks)
# If process is canceled 
[ -z "$input" ] && exit 1
# Add url if it does not exist in bookmark file
if [[ $input =~ ".com" ]]
then
  grep "$input" $file_bookmarks > /dev/null ||  echo "$input" >> "$file_bookmarks"
  firefox "$input"
else
  firefox "https://searx.bar/search?q=$input"
fi


