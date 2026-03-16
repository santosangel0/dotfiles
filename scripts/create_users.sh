#!/bin/bash
# Title: create_users.sh
# Usage: Run as root to setup the fellowship

# Check for dialog
if ! command -v dialog &> /dev/null; then
    pacman -S --noconfirm dialog
fi

# 1. Setup Strider (Standard User)
STRIDER=$(dialog --title "Character Creation" --inputbox "Enter the name for Strider (Standard User):" 8 40 "strider" --output-fd 1)
useradd -m -s /bin/bash "$STRIDER"
passwd "$STRIDER"

# 2. Setup Wizard (Sudoer)
WIZARD=$(dialog --title "Character Creation" --inputbox "Enter the name for the Wizard (Sudoer):" 8 40 "wizard" --output-fd 1)
useradd -m -G wheel -s /bin/bash "$WIZARD"
passwd "$WIZARD"

dialog --msgbox "The Fellowship is formed. $WIZARD has been granted the sudo." 6 50
