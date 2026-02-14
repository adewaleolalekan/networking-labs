#!/bin/bash

# This script runs in the background when step 1 starts
# Install required tools and set up test services

echo "Setting up lab environment..."

# Update package lists quietly
apt-get update -qq > /dev/null 2>&1

# Install required tools
apt-get install -y -qq \
    netcat-openbsd \
    net-tools \
    iproute2 \
    curl \
    wget \
    lsof \
    nmap \
    telnet \
    dnsutils \
    iperf3 > /dev/null 2>&1

# Create a simple TCP server for testing
mkdir -p /root/lab2

# Create a simple HTTP server script
cat > /root/lab2/simple-server.py << 'EOF'
#!/usr/bin/env python3
import http.server
import socketserver

PORT = 8080

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Server running on port {PORT}")
    httpd.serve_forever()
EOF

chmod +x /root/lab2/simple-server.py

# Create test files to serve
cat > /root/lab2/index.html << 'EOF'
<html>
<head><title>Test Server</title></head>
<body>
<h1>Lab 2 Test Server</h1>
<p>This is a simple HTTP server for testing TCP connections.</p>
</body>
</html>
EOF

# Create helper script for common port information
cat > /usr/local/bin/common-ports << 'EOF'
#!/bin/bash
echo "Common Port Numbers:"
echo "===================="
echo "HTTP:       80   (TCP)"
echo "HTTPS:      443  (TCP)"
echo "SSH:        22   (TCP)"
echo "FTP:        21   (TCP)"
echo "DNS:        53   (TCP/UDP)"
echo "SMTP:       25   (TCP)"
echo "MySQL:      3306 (TCP)"
echo "PostgreSQL: 5432 (TCP)"
echo "Redis:      6379 (TCP)"
echo "MongoDB:    27017 (TCP)"
echo ""
echo "Kubernetes Ports:"
echo "===================="
echo "API Server: 6443 (TCP)"
echo "kubelet:    10250 (TCP)"
echo "NodePort:   30000-32767 (TCP/UDP)"
EOF

chmod +x /usr/local/bin/common-ports

# Signal completion
echo "setup-complete" > /tmp/setup-complete

echo "Lab environment ready!"
