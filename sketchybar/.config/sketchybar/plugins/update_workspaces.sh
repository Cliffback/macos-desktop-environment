#!/bin/bash

declare -A changes_on changes_off

for mid in $(aerospace list-monitors); do
  for sid in $(aerospace list-workspaces --monitor "$mid" --empty no); do
    changes_on["$sid"]=1
  done
  for sid in $(aerospace list-workspaces --monitor "$mid" --empty); do
    changes_off["$sid"]=1
  done
done

# Ensure focused workspace is always set to drawing=on and icon.highlight=on
if [ -n "$FOCUSED_WORKSPACE" ]; then
  changes_on["$FOCUSED_WORKSPACE"]=1
  unset changes_off["$FOCUSED_WORKSPACE"] # Remove from changes_off if present
  sketchybar --set space.$FOCUSED_WORKSPACE icon.highlight=on
fi

for sid in "${!changes_off[@]}"; do
  # Avoid turning off if it's already in the "on" list
  if [ -z "${changes_on[$sid]}" ]; then
    sketchybar --set space.$sid drawing=off
  fi
done

# Apply changes at the end
for sid in "${!changes_on[@]}"; do
  sketchybar --set space.$sid drawing=on
done

