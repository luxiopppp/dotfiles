#!/usr/bin/env bash

IMAGES_DIR="$HOME/Documents/kde_connect"

if [ -z "$1" ]; then
  IMAGE=$(find "$IMAGES_DIR" -maxdepth 1 \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -type f -printf "%T@ %p\n" | sort -nr | awk '{print $2; exit}')
  echo $IMAGE
  if [ -z "$IMAGE" ]; then
    exit 1
  fi
else
  IMAGE="$1"
fi

TEMP_PNG="/tmp/clipboard_image.png"
magick "$IMAGE" "$TEMP_PNG"

xclip -selection clipboard -t image/png -i "$TEMP_PNG"
