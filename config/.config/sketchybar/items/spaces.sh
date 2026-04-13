#!/bin/bash

# Get aerospace workspaces in the correct order from aerospace.toml
# This reads the workspace order from the aerospace config file
AEROSPACE_CONFIG="$HOME/.config/aerospace/aerospace.toml"
MAIN_WORKSPACES=""
EXTERNAL_WORKSPACES=""

if [ -f "$AEROSPACE_CONFIG" ]; then
  # Parse workspace assignments and separate main vs external
  # Use process substitution to avoid subshell issues
  while IFS= read -r line; do
    # Extract workspace name (before =) and monitor assignment (after =)
    WORKSPACE=$(echo "$line" | sed 's/[[:space:]]*=.*//')
    MONITOR=$(echo "$line" | sed "s/.*=[[:space:]]*['\"]//" | sed "s/['\"].*//")
    
    if [ "$MONITOR" = "main" ]; then
      MAIN_WORKSPACES="$MAIN_WORKSPACES $WORKSPACE"
    else
      # External monitor (secondary, etc.)
      EXTERNAL_WORKSPACES="$EXTERNAL_WORKSPACES $WORKSPACE"
    fi
  done < <(grep -A 50 "\[workspace-to-monitor-force-assignment\]" "$AEROSPACE_CONFIG" | grep -E "^[a-z0-9]+\s*=")
  
  # Trim spaces
  MAIN_WORKSPACES=$(echo $MAIN_WORKSPACES | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  EXTERNAL_WORKSPACES=$(echo $EXTERNAL_WORKSPACES | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  
  # Always show only main workspaces, keep external workspaces hidden
  AEROSPACE_WORKSPACES="$MAIN_WORKSPACES"
  
  # Fallback to default if empty
  if [ -z "$AEROSPACE_WORKSPACES" ]; then
    AEROSPACE_WORKSPACES="u i o p"
  fi
else
  # Fallback to default order if config file not found
  AEROSPACE_WORKSPACES="u i o p"
fi

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

# Remove all existing workspace items and separators to avoid duplicates
sketchybar --remove '/space\..*/' '/separator\..*/' 2>/dev/null || true

# Create all workspaces (both main and external, but external will be hidden)
ALL_WORKSPACES_TO_CREATE="$MAIN_WORKSPACES"
if [ -n "$EXTERNAL_WORKSPACES" ]; then
  ALL_WORKSPACES_TO_CREATE="$MAIN_WORKSPACES $EXTERNAL_WORKSPACES"
fi

spaces=()
workspace_count=0
total_visible_workspaces=$(echo $AEROSPACE_WORKSPACES | wc -w)

# Create all workspace items (main + external)
for workspace in $ALL_WORKSPACES_TO_CREATE; do
  # Determine if this is an external workspace
  IS_EXTERNAL=false
  for ext_ws in $EXTERNAL_WORKSPACES; do
    if [ "$workspace" = "$ext_ws" ]; then
      IS_EXTERNAL=true
      break
    fi
  done
  
  # Always hide external workspaces, only show main workspaces
  DRAWING="on"
  if [ "$IS_EXTERNAL" = "true" ]; then
    DRAWING="off"
  fi
  
  space=(
    icon=$workspace
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color=$KANAGAWA_BRIGHT_RED
    label.font="sketchybar-app-font:Regular:16.0"
    label.background.height=26
    label.background.drawing=on
    label.background.color=$BACKGROUND_2
    label.background.corner_radius=8
    label.drawing=off
    drawing=$DRAWING
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add item space.$workspace left     \
             --set space.$workspace "${space[@]}" \
             --subscribe space.$workspace mouse.clicked aerospace_workspace_change

  # Add separator between VISIBLE workspaces only (not after the last visible one)
  # Only add separators for main workspaces, not external ones
  if [ "$IS_EXTERNAL" = "false" ]; then
    workspace_count=$((workspace_count + 1))
    if [ $workspace_count -lt $total_visible_workspaces ]; then
      separator_config=(
        icon="|"
        icon.font="$FONT:Regular:14.0"
        icon.color=$KANAGAWA_FG4
        padding_left=5
        padding_right=5
        label.drawing=off
        associated_display=active
      )
      
      sketchybar --add item separator.$workspace left \
                 --set separator.$workspace "${separator_config[@]}"
    fi
  fi
done

spaces_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  click_script='aerospace workspace --create && sketchybar --trigger aerospace_workspace_change'
  icon.color=$KANAGAWA_FG1
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces_bracket[@]}" \
                                              \
           --add item separator left          \
           --set separator "${separator[@]}"
