#!/bin/bash
# Title: build_special.sh
# Purpose: Builds AUR packages (Chrome) and Suckless tools using AUR PKGBUILDs
# with custom config.h files.
# Run this as your Sudo user (Wizard).

DOTFILES="$HOME/dotfiles"
BUILD_DIR="/tmp/aur_builds"

# Ensure build directory exists
mkdir -p "$BUILD_DIR"

# --- Function to build using AUR PKGBUILD and custom config.h ---
build_aur_custom() {
    local repo_url=$1
    local pkg_name=$2
    local custom_config=$3

    echo "--------------------------------------------------"
    echo "Preparing to forge $pkg_name from AUR..."
    echo "--------------------------------------------------"

    # Clean previous attempts
    rm -rf "$BUILD_DIR/$pkg_name"
    
    # Clone the AUR repository
    git clone "$repo_url" "$BUILD_DIR/$pkg_name"
    
    # Inject your custom config.h if provided
    if [ -n "$custom_config" ] && [ -f "$DOTFILES/$custom_config" ]; then
        echo "Injecting custom config.h from $DOTFILES/$custom_config..."
        cp "$DOTFILES/$custom_config" "$BUILD_DIR/$pkg_name/config.h"
    fi

    # Build and install using makepkg
    # -s: install dependencies, -i: install package, --noconfirm: skip prompts
    cd "$BUILD_DIR/$pkg_name" && makepkg -si --noconfirm
}

# --- 1. Build DWM ---
# Uses the custom config.h you just defined
build_aur_custom "https://aur.archlinux.org/dwm.git" "dwm" "dwm/config.h"

# --- 2. Build ST ---
# Assuming you will place a similar custom config.h for st in ~/dotfiles/st/
build_aur_custom "https://aur.archlinux.org/st.git" "st" "st/config.h"

# --- 3. Build Google Chrome ---
# Chrome doesn't use a config.h, so the third argument is left empty
build_aur_custom "https://aur.archlinux.org/google-chrome.git" "google-chrome" ""

echo "--------------------------------------------------"
echo "All builds completed. The Fellowship is well-equipped."
echo "--------------------------------------------------"
