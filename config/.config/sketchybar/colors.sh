#!/bin/bash

# Tokyo Night Storm Color Palette
export BLACK=0xff1a1b26
export WHITE=0xffc0caf5
export RED=0xfff7768e
export GREEN=0xff9ece6a
export BLUE=0xff7aa2f7
export YELLOW=0xffe0af68
export ORANGE=0xffff9e64
export MAGENTA=0xffbb9af7
export CYAN=0xff7dcfff
export GREY=0xff565f89
export TRANSPARENT=0x00000000

# Tokyo Night Storm specific colors
export TOKYO_BG=0xff1a1b26
export TOKYO_BG_DARK=0xff16161e
export TOKYO_BG_HIGHLIGHT=0xff2f3549
export TOKYO_FG=0xffc0caf5
export TOKYO_FG_DARK=0xffa9b1d6
export TOKYO_FG_GUTTER=0xff3b4261
export TOKYO_FG_COMMENT=0xff565f89

# Tokyo Night Storm accent colors
export TOKYO_BRIGHT_RED=0xfff7768e
export TOKYO_BRIGHT_GREEN=0xff9ece6a
export TOKYO_BRIGHT_YELLOW=0xffe0af68
export TOKYO_BRIGHT_BLUE=0xff7aa2f7
export TOKYO_BRIGHT_PURPLE=0xffbb9af7
export TOKYO_BRIGHT_CYAN=0xff7dcfff
export TOKYO_BRIGHT_ORANGE=0xffff9e64

# General bar colors - Tokyo Night Storm theme
# BAR_COLOR uses semi-transparent background (0x60 = ~37% opacity) to show wallpaper through blur
export BAR_COLOR=0x601a1b26 # Semi-transparent Tokyo Night Storm background
export ICON_COLOR=$TOKYO_FG # Color of all icons
export LABEL_COLOR=$TOKYO_FG # Color of all labels
export BACKGROUND_1=$TOKYO_BG_HIGHLIGHT # Container background
export BACKGROUND_2=$TOKYO_FG_GUTTER # Container border color

export POPUP_BACKGROUND_COLOR=0xff2f3549
export POPUP_BORDER_COLOR=$TOKYO_BRIGHT_BLUE

export SHADOW_COLOR=$BLACK

# Legacy Kanagawa variables for compatibility (mapped to Tokyo Night Storm)
export KANAGAWA_BG0=$TOKYO_BG
export KANAGAWA_BG1=$TOKYO_BG_HIGHLIGHT
export KANAGAWA_BG2=$TOKYO_FG_GUTTER
export KANAGAWA_FG0=$TOKYO_FG
export KANAGAWA_FG1=$TOKYO_FG
export KANAGAWA_FG2=$TOKYO_FG_DARK
export KANAGAWA_FG3=$TOKYO_FG_DARK
export KANAGAWA_FG4=$TOKYO_FG_COMMENT
export KANAGAWA_BRIGHT_RED=$TOKYO_BRIGHT_RED
export KANAGAWA_BRIGHT_GREEN=$TOKYO_BRIGHT_GREEN
export KANAGAWA_BRIGHT_YELLOW=$TOKYO_BRIGHT_YELLOW
export KANAGAWA_BRIGHT_BLUE=$TOKYO_BRIGHT_BLUE
export KANAGAWA_BRIGHT_PURPLE=$TOKYO_BRIGHT_PURPLE
