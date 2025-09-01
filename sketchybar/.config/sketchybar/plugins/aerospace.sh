#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.highlight=on # background.drawing=on
else
    sketchybar --set $NAME icon.highlight=off # background.drawing=off
fi
