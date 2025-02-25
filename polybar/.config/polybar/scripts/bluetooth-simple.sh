#!/usr/bin/env bash

# check if a device is connected by bluetooth using bluetoothctl
info=$(bluetoothctl devices Connected | grep Device)

# show some output when it is
if echo "$info" | grep -q "Device";
then
	# Connected
	echo %{T2}'󰂯'%{T-}
else
	# Not Connected
	echo ''
fi
