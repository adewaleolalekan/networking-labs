#!/bin/bash

# Check if answer file exists
if [ ! -f /root/lab2/step2-answers.txt ]; then
    echo "❌ File not found: /root/lab2/step2-answers.txt"
    exit 1
fi

# Source the answers
source /root/lab2/step2-answers.txt

errors=0

# Check HTTP server port
if [ "$http_server_port" != "8080" ]; then
    echo "❌ http_server_port incorrect. Expected: 8080"
    echo "   Hint: Look for python3 in 'ss -tlnp' output"
    errors=$((errors + 1))
else
    echo "✓ http_server_port correct (8080)"
fi

# Check SSH listening
if [ "$ssh_listening" != "yes" ]; then
    echo "❌ ssh_listening incorrect. SSH daemon should be running on port 22"
    echo "   Hint: Look for sshd in 'ss -tlnp' output"
    errors=$((errors + 1))
else
    echo "✓ ssh_listening correct (yes)"
fi

# Get actual count of listening TCP ports
actual_count=$(ss -tlnp 2>/dev/null | grep LISTEN | wc -l)

# Accept answers within reasonable range (different systems may vary)
if [ "$tcp_listening_count" -lt 2 ] || [ "$tcp_listening_count" -gt 10 ]; then
    echo "❌ tcp_listening_count seems incorrect. Expected: $actual_count"
    echo "   Hint: Run 'ss -tlnp | grep LISTEN | wc -l'"
    errors=$((errors + 1))
else
    echo "✓ tcp_listening_count is reasonable ($tcp_listening_count)"
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 Excellent port scanning skills!"
    echo ""
    echo "You've learned to:"
    echo "• Use netcat for port scanning"
    echo "• Identify listening services with ss/lsof"
    echo "• Match services to their ports"
    echo ""
    echo "These skills are essential for Kubernetes troubleshooting!"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s)"
    echo ""
    echo "💡 Debug commands:"
    echo "  ss -tlnp          # Show listening TCP ports"
    echo "  sudo lsof -i TCP  # Show TCP connections"
    echo "  nc -zv localhost PORT  # Test specific port"
    exit 1
fi
