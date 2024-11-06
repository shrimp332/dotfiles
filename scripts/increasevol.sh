#!/usr/bin/env bash
pactl set-sink-mute @DEFAULT_SINK@ 0
if [ $(($(pamixer --get-volume) + 5)) -ge 120 ]; then
	pactl set-sink-volume @DEFAULT_SINK@ 120%
else
	pactl set-sink-volume @DEFAULT_SINK@ +5%
fi
