#!/bin/bash
swayidle -w before-sleep 'playerctl pause' \
	before-sleep 'pactl set-sink-mute @DEFAULT_SINK@ 1' \
	before-sleep 'brightnessctl set 40%' \
	timeout 600 'systemctl suspend'
