
#!/bin/bash

# OIBSIP Task 2 - UFW Firewall Configuration

set -e

# Check administrator privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script using sudo."
    exit 1
fi

echo "Starting UFW configuration..."

# Install UFW if necessary
if ! command -v ufw >/dev/null 2>&1; then
    apt update
    apt install ufw -y
fi

# Configure default policies
ufw default deny incoming
ufw default allow outgoing

# Configure firewall rules
ufw allow 22/tcp
ufw deny 80/tcp
ufw allow 443/tcp
ufw deny 21/tcp

# Enable firewall
ufw --force enable

echo "Firewall configuration completed!"

# Show firewall status
ufw status verbose
