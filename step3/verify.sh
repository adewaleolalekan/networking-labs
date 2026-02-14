#!/bin/bash

if [ ! -f /root/lab1/step3-answers.txt ]; then
    echo "❌ File not found: /root/lab1/step3-answers.txt"
    exit 1
fi

source /root/lab1/step3-answers.txt

errors=0

# Check host_bits
if [ "$host_bits" != "6" ]; then
    echo "❌ host_bits incorrect. Expected: 6, Got: $host_bits"
    echo "   Hint: 32 - 26 = ?"
    errors=$((errors + 1))
else
    echo "✓ host_bits correct (6)"
fi

# Check total_addresses
if [ "$total_addresses" != "64" ]; then
    echo "❌ total_addresses incorrect. Expected: 64, Got: $total_addresses"
    echo "   Hint: 2^6 = ?"
    errors=$((errors + 1))
else
    echo "✓ total_addresses correct (64)"
fi

# Check network_address
if [ "$network_address" != "10.10.10.0" ]; then
    echo "❌ network_address incorrect. Expected: 10.10.10.0, Got: $network_address"
    errors=$((errors + 1))
else
    echo "✓ network_address correct"
fi

# Check broadcast_address
if [ "$broadcast_address" != "10.10.10.63" ]; then
    echo "❌ broadcast_address incorrect. Expected: 10.10.10.63, Got: $broadcast_address"
    echo "   Hint: For /26, range is only 64 addresses (0-63)"
    errors=$((errors + 1))
else
    echo "✓ broadcast_address correct"
fi

# Check first_usable
if [ "$first_usable" != "10.10.10.1" ]; then
    echo "❌ first_usable incorrect. Expected: 10.10.10.1, Got: $first_usable"
    errors=$((errors + 1))
else
    echo "✓ first_usable correct"
fi

# Check last_usable
if [ "$last_usable" != "10.10.10.62" ]; then
    echo "❌ last_usable incorrect. Expected: 10.10.10.62, Got: $last_usable"
    errors=$((errors + 1))
else
    echo "✓ last_usable correct"
fi

# Check usable_hosts
if [ "$usable_hosts" != "62" ]; then
    echo "❌ usable_hosts incorrect. Expected: 62, Got: $usable_hosts"
    errors=$((errors + 1))
else
    echo "✓ usable_hosts correct"
fi

if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 Excellent work!"
    echo ""
    echo "You've mastered /26 subnets!"
    echo "Remember: /26 = 64 addresses (not 256 like /24)"
    exit 0
else
    echo ""
    echo "⚠️  $errors error(s) found. Review the hints and try again."
    exit 1
fi
