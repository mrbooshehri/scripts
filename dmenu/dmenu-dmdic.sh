#! /bin/bash
menu=$(dmenu -p "Enter your word:"<&-)
python3 ~/pythonTools/dictionary/main.py $menu | dmenu -l 15
