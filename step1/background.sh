#!/bin/bash

# This script runs in the background when step 1 starts
# Install required tools

echo "Installing subnet calculation tools..."

# Install ipcalc and sipcalc
apt-get update -qq > /dev/null 2>&1
apt-get install -y ipcalc sipcalc > /dev/null 2>&1

# Create a helper script
cat > /usr/local/bin/check-answer << 'EOF'
#!/bin/bash
# Helper script to validate subnet calculations

if [ $# -ne 2 ]; then
    echo "Usage: check-answer <your-answer> <correct-answer>"
    exit 1
fi

if [ "$1" = "$2" ]; then
    echo "✓ Correct!"
    exit 0
else
    echo "✗ Incorrect. Expected: $2, Got: $1"
    exit 1
fi
EOF

chmod +x /usr/local/bin/check-answer

# Create workspace directory
mkdir -p /root/lab1
cd /root/lab1

echo "Setup complete!" > /tmp/setup-complete
