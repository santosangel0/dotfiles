#!/bin/bash
# .xinitrc - Minimalist startup script

# Keyboard layout
setxkbmap br &

# Status bar
slstatus &

# Background/Wallpaper (optional future)
# feh --bg-scale ~/wallpapers/bg.jpg &

# Launch DWM
exec dwm
