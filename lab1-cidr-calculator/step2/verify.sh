#!/bin/bash

# Check if answer file exists
if [ ! -f /root/lab1/step2-answers.txt ]; then
    echo "❌ File not found: /root/lab1/step2-answers.txt"
    exit 1
fi

# Source the answers
source /root/lab1/step2-answers.txt

# Expected answers
expected_network="192.168.1.0"
expected_broadcast="192.168.1.255"
expected_first="192.168.1.1"
expected_last="192.168.1.254"
expected_hosts="254"

errors=0

# Validate network address
if [ "$network_address" != "$expected_network" ]; then
    echo "❌ network_address is incorrect"
    echo "   Expected: $expected_network"
    echo "   Got: $network_address"
    errors=$((errors + 1))
else
    echo "✓ network_address is correct"
fi

# Validate broadcast address
if [ "$broadcast_address" != "$expected_broadcast" ]; then
    echo "❌ broadcast_address is incorrect"
    echo "   Expected: $expected_broadcast"
    echo "   Got: $broadcast_address"
    errors=$((errors + 1))
else
    echo "✓ broadcast_address is correct"
fi

# Validate first usable
if [ "$first_usable" != "$expected_first" ]; then
    echo "❌ first_usable is incorrect"
    echo "   Expected: $expected_first"
    echo "   Got: $first_usable"
    errors=$((errors + 1))
else
    echo "✓ first_usable is correct"
fi

# Validate last usable
if [ "$last_usable" != "$expected_last" ]; then
    echo "❌ last_usable is incorrect"
    echo "   Expected: $expected_last"
    echo "   Got: $last_usable"
    errors=$((errors + 1))
else
    echo "✓ last_usable is correct"
fi

# Validate usable hosts
if [ "$usable_hosts" != "$expected_hosts" ]; then
    echo "❌ usable_hosts is incorrect"
    echo "   Expected: $expected_hosts"
    echo "   Got: $usable_hosts"
    errors=$((errors + 1))
else
    echo "✓ usable_hosts is correct"
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 Perfect! All values are correct!"
    echo ""
    echo "Key Takeaway:"
    echo "For a /24 network:"
    echo "- 256 total addresses (2^8)"
    echo "- 254 usable (minus network and broadcast)"
    echo "- Range: .1 through .254"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s)"
    echo ""
    echo "💡 Hints:"
    echo "- Network address ends in .0 for /24"
    echo "- Broadcast address ends in .255 for /24"
    echo "- First usable is network + 1"
    echo "- Last usable is broadcast - 1"
    echo "- Usable hosts = total - 2"
    exit 1
fi
