#!/bin/bash

# Screencast settings
VIDEO_BITRATE="5000k"
# WIDTH=1366
# HEIGHT=768
AUDIO_BITRATE="128k" 
AUDIO_RATE="48000"

# Get current screen width and height
SCREEN_WIDTH=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3}')
SCREEN_HEIGHT=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $4}')

# Capture video
ffmpeg -f x11grab -s ${WIDTH:-$SCREEN_WIDTH}x${HEIGHT:-$SCREEN_HEIGHT} -r 25 -i $DISPLAY \
    -f alsa -i pulse -c:v libx264 -b:v "$VIDEO_BITRATE" \
    -acodec libmp3lame -ab "$AUDIO_BITRATE" -ar "$AUDIO_RATE" -ac 2 "$1"

