#!/bin/bash

# It is a fork of https://github.com/thiago-negri/utils/blob/master/webcam_overlay.sh by thiago-negri
# I have modified this script to work with mpv instead mplayer.
# Emilio Silveira.

# Settings
CAM_WIDTH=224
CAM_HEIGHT=168
DEVICE=/dev/video0

# To keep the overlay on all workspaces:
#
# 1. Focus on the webcam overlay window, press Alt+Space to open context menu
#    and select 'Always on Visible Workspace'; or
# 2. Install 'compizconfig-settings-manager' and 'compiz-plugins', open up
#    compiz settings manager, enable 'Windows Rules' plugin and add to
#    'Sticky' rule: 'class=mpv'. This will make every mpv window to
#    be always visible.

# Get current screen width and height
SCREEN_WIDTH=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3}')
SCREEN_HEIGHT=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $4}')

# Calculate horizontal and vertical offset to position the webcam overlay at
# bottom right corner
HORIZONTAL_OFFSET=$(expr $SCREEN_WIDTH - $CAM_WIDTH)
VERTICAL_OFFSET=$(expr $SCREEN_HEIGHT - $CAM_HEIGHT) 

mpv -ontop -no-border \
    -geometry ${CAM_WIDTH}x${CAM_HEIGHT}+${HORIZONTAL_OFFSET}+${VERTICAL_OFFSET} \
    -tv driver=v4l2:width=${CAM_WIDTH}:height=${CAM_HEIGHT}:device=${DEVICE} tv://
