#! /bin/bash
sleep 0.1 && scrot ~/Pictures/%Y-%m-%d_screenshot.png -f -l width=3 -s -q 100 -e 'notify-send -t 3000 "Screenshot taken" "$f"'
