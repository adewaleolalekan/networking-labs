#!/bin/bash

# This script runs once when the scenario first loads
# Useful for pre-installing packages or setting up the environment

echo "Preparing lab environment..."

# Update package lists quietly
apt-get update -qq

# Install all needed tools
apt-get install -y -qq \
    ipcalc \
    sipcalc \
    iputils-ping \
    net-tools \
    dnsutils \
    curl

# Create welcome message
cat > /etc/motd << 'EOF'
╔═══════════════════════════════════════╗
║   Networking Lab Environment Ready    ║
║                                       ║
║   Tools installed:                    ║
║   • ipcalc - subnet calculator        ║
║   • sipcalc - advanced calculator     ║
║   • Network troubleshooting tools     ║
╚═══════════════════════════════════════╝

EOF

echo "Environment ready!"
