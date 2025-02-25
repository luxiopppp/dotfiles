#!/bin/sh

selected=$(echo "NO|YES" | rofi -dmenu -sep "|" -p "Confirm:")
[[ -z $selected ]] && exit
echo $selected
