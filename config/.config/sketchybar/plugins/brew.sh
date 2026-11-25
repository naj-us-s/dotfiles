#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

COUNT=$(brew outdated | wc -l | tr -d ' ')

COLOR=$RED

case "$COUNT" in
  [3-5][0-9]) COLOR=$MAGENTA
  ;;
  [1-2][0-9]) COLOR=$BLUE
  ;;
  [1-9]) COLOR=$WHITE
  ;;
  0) COLOR=$MAGENTA
     COUNT=􀆅
  ;;
esac

sketchybar --set $NAME label=$COUNT icon.color=$COLOR
