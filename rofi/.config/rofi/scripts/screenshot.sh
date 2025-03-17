#!/bin/sh

OPTIONS="Full\nWindow\nSelection"
CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -p "Screenshot type:")

# spectacle = /usr/bin/spectacle

case "$CHOSEN" in
  "Full")
    /usr/bin/spectacle -f -b -c
    ;;
  "Window")
    /usr/bin/spectacle -a -b -c
    ;;
  "Selection")
    /usr/bin/spectacle -r -b -c
    ;;
  *)
    exit 1
    ;;
esac
