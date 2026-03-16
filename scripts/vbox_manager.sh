#!/bin/bash
# Title: vbox_manager.sh
# Purpose: Toggle VM services and manage Windows Shared Folders

# Ensure dialog is installed
if ! command -v dialog &> /dev/null; then
    sudo pacman -S --noconfirm dialog
fi

# Function to mount the shared folder (The Bridge to Windows)
mount_share() {
    # Ensure the mount point exists
    [ -d "~/shared" ] || mkdir -p ~/shared
    
    # Attempt to mount (vboxsf is the VBox Shared Folder driver)
    if sudo mount -t vboxsf vbox_share ~/shared; then
        dialog --msgbox "Bridge established! Windows share mounted at ~/shared" 6 50
    else
        dialog --errorbox "Failed to mount. Ensure 'vbox_share' is set in VirtualBox settings." 6 50
    fi
}

disable_vbox() {
    pkill -9 VBoxClient
    sudo umount ~/shared 2>/dev/null
    dialog --msgbox "VirtualBox services banished and shares unmounted!" 6 50
}

enable_vbox() {
    pkill -9 VBoxClient
    (sleep 2 && VBoxClient --clipboard) &
    (sleep 2 && VBoxClient --display) &
    (sleep 2 && VBoxClient --draganddrop) &
    mount_share
}

# Main Menu
CHOICE=$(dialog --clear \
                --title "Wizard's VM & Portal Management" \
                --menu "Choose an action:" \
                15 50 4 \
                1 "Enable VBox Services & Mount Windows Share" \
                2 "Disable Services & Unmount Share" \
                3 "Exit" \
                2>&1 >/dev/tty)

case $CHOICE in
    1) enable_vbox ;;
    2) disable_vbox ;;
    *) exit ;;
esac
