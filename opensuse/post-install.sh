#!/bin/bash
# post-install.sh

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# Set execution permissions
chmod +x system-base.sh gaming-setup.sh dev-setup.sh

# Execute scripts in order
./system-base.sh
./gaming-setup.sh
./dev-setup.sh

echo "------------------------------------------------------------"
echo "All modules installed successfully!"
echo "------------------------------------------------------------"