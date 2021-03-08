#!/bin/bash
menu=$(dmenu -p "Enter your word:"<&-)
dict $menu | dmenu -l 25
