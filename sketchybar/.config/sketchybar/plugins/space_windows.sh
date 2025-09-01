#!/bin/bash

if [ "$SENDER" = "aerospace_monitor_change" ]; then
  sketchybar --set space."$FOCUSED_WORKSPACE" display="$TARGET_MONITOR"
  exit 0
fi

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  prevapps=$(aerospace list-windows --workspace "$PREV_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  if [ "${prevapps}" != "" ]; then
    sketchybar --set space.$PREV_WORKSPACE drawing=on
  else
    #WARN: moves empty workspaces back to monitor 1
    ###### this assumes monitor 1 is your main monitor
    aerospace move-workspace-to-monitor --workspace "$PREV_WORKSPACE" 1
    sketchybar --set space.$PREV_WORKSPACE drawing=off display=1
  fi
else
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
fi

sketchybar --set space.$FOCUSED_WORKSPACE drawing=on
