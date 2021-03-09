#! /bin/bash

mkdir -p $HOME/.cache/jq_dic

if [ -z $1 ]; then
  word=$(echo "" | dmenu -p "Look up for: ")
else
  word=$1
fi

baseurl="https://api.dictionaryapi.dev/api/v2/entries/en_US/"
cachedir="$HOME/.cache/jq_dic"

#curl -s $baseurl$word > $cachedir/temp.bw

#jq -r '.[].meanings[] |.partOfSpeech, .definitions[].definition, .definitions[].synonyms[]?' $cachedir/temp.bw > $cachedir/filterd.bw

## Just synonyms

printf "$(curl -s $baseurl$word | jq -r '.[].meanings[] | .definitions[].synonyms[]?')" | dmenu -l 15 -p "Synonyms of [ $word ]"
