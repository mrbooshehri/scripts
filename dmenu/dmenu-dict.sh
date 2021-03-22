#! /bin/bash

baseurl="https://api.dictionaryapi.dev/api/v2/entries/en_US/"
word=$(dmenu -p "Look up for:"<&-)

if [ ! -z $word ]; then
	selected=$(echo -n "$(curl -4s $baseurl$word | jq -r '.[].meanings[] | .definitions[].synonyms[]?')" \
	  | dmenu -l 15 -p "Synonyms of [ $word ]")  
	if [ ! -z $selected ]; then
	  	echo "$word = $selected" >> ~/notes/vocab.md
		echo $selected | xsel -bi
		notify-send -t 2000 -u normal "[ $selected ] copied to clipboard."
	fi
fi
