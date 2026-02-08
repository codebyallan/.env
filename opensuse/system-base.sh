#!/bin/bash
# system-base.sh

if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# 1. Multimedia codecs (Packman)
zypper ar -f -p 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
zypper --gpg-auto-import-keys refresh
zypper dup --from packman --allow-vendor-change -y

# 2. System update
zypper dup -y

# 3. Base utilities
zypper install -y --no-recommends \
    unrar 7zip git bash-completion ffmpeg-4 \
    zram-generator ucode-amd kernel-firmware-amdgpu sensors

# 4. System stability (16GB zRAM)
echo -e "[zram0]\nzram-size = ram / 2\ncompression-algorithm = zstd\nswap-priority = 100" > /etc/systemd/zram-generator.conf
systemctl daemon-reload
systemctl start /dev/zram0

# 5. Essential apps (Flatpak)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub \
    com.discordapp.Discord \
    org.telegram.desktop \
    com.github.tchx84.Flatseal

echo "System base setup completed!"