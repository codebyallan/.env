#!/bin/bash
# dev-setup.sh

if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# 1. Microsoft & VS Code repositories
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo -f https://packages.microsoft.com/opensuse/15/prod/ microsoft-prod
zypper addrepo -f https://packages.microsoft.com/yumrepos/vscode vscode
zypper --gpg-auto-import-keys refresh

# 2. Development SDKs and IDE
zypper install -y --no-recommends \
    dotnet-sdk-10.0 code \
    podman podman-compose

# 3. Development GUI
flatpak install -y flathub io.podman_desktop.PodmanDesktop

echo "Development setup completed!"