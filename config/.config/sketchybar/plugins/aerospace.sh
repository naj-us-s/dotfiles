#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

# Get current aerospace workspace
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null | head -n1)

# Get all workspaces in the correct order from aerospace.toml
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
  ALL_WORKSPACES="$MAIN_WORKSPACES"
  
  # Fallback to default if empty
  if [ -z "$ALL_WORKSPACES" ]; then
    ALL_WORKSPACES="u i o p"
  fi
else
  # Fallback to default order if config file not found
  ALL_WORKSPACES="u i o p"
fi

update_workspace_display() {
  args=()
  
  # Re-parse workspace assignments (since this function may be called independently)
  MAIN_WS=""
  EXT_WS=""
  AEROSPACE_CONFIG="$HOME/.config/aerospace/aerospace.toml"
  
  if [ -f "$AEROSPACE_CONFIG" ]; then
    while IFS= read -r line; do
      WORKSPACE=$(echo "$line" | sed 's/[[:space:]]*=.*//')
      MONITOR=$(echo "$line" | sed "s/.*=[[:space:]]*['\"]//" | sed "s/['\"].*//")
      
      if [ "$MONITOR" = "main" ]; then
        MAIN_WS="$MAIN_WS $WORKSPACE"
      else
        EXT_WS="$EXT_WS $WORKSPACE"
      fi
    done < <(grep -A 50 "\[workspace-to-monitor-force-assignment\]" "$AEROSPACE_CONFIG" | grep -E "^[a-z0-9]+\s*=")
    
    MAIN_WS=$(echo $MAIN_WS | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    EXT_WS=$(echo $EXT_WS | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  fi
  
  # Always show only main workspaces, keep external workspaces hidden
  CURRENT_ALL_WORKSPACES="$MAIN_WS"
  
  # Always keep external workspaces hidden
  for workspace in $EXT_WS; do
    args+=(--set space.$workspace drawing=off)
  done
  
  # Update each workspace item
  for workspace in $CURRENT_ALL_WORKSPACES; do
    if [ "$workspace" = "$CURRENT_WORKSPACE" ]; then
      # Current workspace - highlight it
      args+=(--set space.$workspace background.drawing=on background.color=$BACKGROUND_2 icon.color=$KANAGAWA_BRIGHT_RED)
    else
      # Other workspaces - dim them
      args+=(--set space.$workspace background.drawing=off icon.color=$KANAGAWA_FG1)
    fi
  done
  
  if [ ${#args[@]} -gt 0 ]; then
    sketchybar -m "${args[@]}"
  fi
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # Right click - destroy workspace (if aerospace supports it)
    aerospace workspace --close $SID 2>/dev/null || true
    sketchybar --trigger aerospace_workspace_change
  else
    # Left click - focus workspace
    aerospace workspace $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "aerospace_workspace_change") update_workspace_display
  ;;
  "forced") update_workspace_display
  ;;
  *) update_workspace_display
  ;;
esac

