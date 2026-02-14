#!/bin/bash

# Wait for setup to complete
while [ ! -f /tmp/setup-complete ]; do
    sleep 1
done

# Check if answer file exists
if [ ! -f /root/lab1/step1-answers.txt ]; then
    echo "❌ File not found: /root/lab1/step1-answers.txt"
    echo "Please create the file with your answers."
    exit 1
fi

# Source the answers
source /root/lab1/step1-answers.txt

# Validate each answer
errors=0

if [ "$network_bits" != "24" ]; then
    echo "❌ network_bits is incorrect. Expected: 24, Got: $network_bits"
    errors=$((errors + 1))
else
    echo "✓ network_bits is correct (24)"
fi

if [ "$host_bits" != "8" ]; then
    echo "❌ host_bits is incorrect. Expected: 8, Got: $host_bits"
    errors=$((errors + 1))
else
    echo "✓ host_bits is correct (8)"
fi

if [ "$total_addresses" != "256" ]; then
    echo "❌ total_addresses is incorrect. Expected: 256, Got: $total_addresses"
    errors=$((errors + 1))
else
    echo "✓ total_addresses is correct (256)"
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 All answers correct! Proceeding to next step..."
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s). Please review and try again."
    echo "Hint: Use 'ipcalc 192.168.1.0/24' to check your calculations"
    exit 1
fi