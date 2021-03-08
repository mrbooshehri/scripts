#! /bin/bash

mkdir -p $HOME/.cache/jq_dic

if [ -z $1 ]; then
  word=$(echo "" | dmenu -p "Word: ")
else
  word=$1
fi

baseurl="https://api.dictionaryapi.dev/api/v2/entries/en_US/"
cachedir="$HOME/.cache/jq_dic"

#curl -s https://api.dictionaryapi.dev/api/v2/entries/en_US/$word | jq -c .[].meaning[] > $cachedir/temp.bw
curl -s https://api.dictionaryapi.dev/api/v2/entries/en_US/$word > $cachedir/temp.bw

jq -c .[].meanings[] $cachedir/temp.bw > $cachedir/filterd.bw

