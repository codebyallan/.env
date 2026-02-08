#!/bin/bash
# gaming-setup.sh

if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# Performance tools (GameMode)
zypper install -y --no-recommends \
    gamemoded libgamemode0-32bit libgamemodeauto0 libgamemodeauto0-32bit

# Gaming Launchers and Tools (Flatpak)
flatpak install -y flathub \
    net.lutris.Lutris \
    com.valvesoftware.Steam \
    com.vysp3r.ProtonPlus \
    com.heroicgameslauncher.hgl

# Flatpak overrides for gaming tools to ensure they have access to necessary system resources
flatpak override --system --talk-name=org.feralinteractive.GameMode

# Enable GameMode service for the real user (not root)
REAL_USER=${SUDO_USER:-$USER}
USER_ID=$(id -u $REAL_USER)

echo "Enabling GameMode service for user $REAL_USER..."
sudo -u $REAL_USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus systemctl --user enable --now gamemoded

echo "Gaming setup completed!"