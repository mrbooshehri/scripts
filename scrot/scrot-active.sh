#! /bin/bash
scrot ~/Pictures/%Y-%m-%d_screenshot.png -u -q 100 -e 'notify-send -t 3000 "Screenshot taken" "$f"'
