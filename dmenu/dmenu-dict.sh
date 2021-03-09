#! /bin/bash

baseurl="https://api.dictionaryapi.dev/api/v2/entries/en_US/"

if [ -z $1 ]; then
  word=$(echo "" | dmenu -p "Look up for: ")
else
  word=$1
fi

selected=$(echo -n "$(curl -s $baseurl$word | jq -r '.[].meanings[] | .definitions[].synonyms[]?')" | dmenu -l 15 -p "Synonyms of [ $word ]")  

echo $selected | xsel -bi

notify-send -t 2000 -u normal "$selected copied to clipboard."
