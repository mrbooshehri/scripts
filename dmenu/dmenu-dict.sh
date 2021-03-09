#! /bin/bash

if [ -z $1 ]; then
  word=$(echo "" | dmenu -p "Look up for: ")
else
  word=$1
fi

printf "$(curl -s $baseurl$word | jq -r '.[].meanings[] | .definitions[].synonyms[]?')" | dmenu -l 15 -p "Synonyms of [ $word ]"
