#!/bin/bash
# gaming-setup.sh

if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# Performance tools (GameMode)
zypper install -y --no-recommends \
    gamemoded libgamemode0-32bit

# Gaming Launchers and Tools (Flatpak)
flatpak install -y flathub \
    net.lutris.Lutris \
    com.valvesoftware.Steam \
    com.vysp3r.ProtonPlus \
    com.heroicgameslauncher.hgl

echo "Gaming setup completed!"