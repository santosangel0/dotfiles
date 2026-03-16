#!/bin/bash
# Title: deploy.sh
# Purpose: Deploy dotfiles 
# Run this as your Strider user.

DOTFILES="$HOME/dotfiles"

echo "Step 1: Installing system packages..."
sudo pacman -S --needed --noconfirm $(grep -v '^#' "$DOTFILES/scripts/packages.txt")

echo "Step 2: Linking configurations..."
# Link Bash
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"
# Link Xinit
ln -sf "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
# Link LF
mkdir -p "$HOME/.config/lf"
ln -sf "$DOTFILES/config/lf/lfrc" "$HOME/.config/lf/lfrc"

echo "Step 3: Building Suckless tools and Chrome..."
bash "$DOTFILES/scripts/build_special.sh"

echo "Deployment complete. Strider is ready to roam."
