#!/bin/sh

CHOSEN=$(echo "Power Off|Lock|Reboot|Suspend|Log Out" | rofi -dmenu -sep "|" -i -p "")

case "$CHOSEN" in
	"Power Off") 
		CONFIRM=$(sh ~/.config/rofi/scripts/confirmation.sh)
		if [ "$CONFIRM" == "YES" ]; then
			poweroff
		fi
		;;
	"Reboot") 
		CONFIRM=$(sh ~/.config/rofi/scripts/confirmation.sh)
		if [ "$CONFIRM" == "YES" ]; then
			reboot
		fi
		;;
	"Suspend") systemctl suspend ;;
	"Log Out") i3-msg exit ;;
	"Lock") betterlockscreen -l blur;;
	*) exit 1 ;;
esac
