#!/usr/bin/bash
# Title: basic_install.sh
# Purpose: Install core packages
# Run this as your Sudo user (Wizard).

DOTFILES="$HOME/dotfiles"

echo "Installing system packages..."
sudo pacman -S --needed --noconfirm $(grep -v '^#' "$DOTFILES/scripts/packages.txt")
