#!/bin/bash

# Check if answer file exists
if [ ! -f /root/lab2/step3-answers.txt ]; then
    echo "❌ File not found: /root/lab2/step3-answers.txt"
    exit 1
fi

# Source the answers
source /root/lab2/step3-answers.txt

errors=0

# Check idle state
if [ "$port_8080_idle_state" != "LISTEN" ]; then
    echo "❌ port_8080_idle_state incorrect. When no one is connected, server is LISTENING."
    errors=$((errors + 1))
else
    echo "✓ port_8080_idle_state correct (LISTEN)"
fi

# Check active state
if [ "$port_8080_active_state" != "ESTAB" ]; then
    echo "❌ port_8080_active_state incorrect. During active connection, state is ESTABLISHED."
    errors=$((errors + 1))
else
    echo "✓ port_8080_active_state correct (ESTAB)"
fi

# Check listening sockets (flexible range)
if [ -z "$listening_sockets" ] || [ "$listening_sockets" -lt 1 ]; then
    echo "❌ listening_sockets incorrect or missing."
    errors=$((errors + 1))
else
    echo "✓ listening_sockets provided ($listening_sockets)"
fi

# Check best command
if [[ "$best_command_for_processes" =~ ^(ss|netstat|lsof)$ ]]; then
    echo "✓ best_command_for_processes correct ($best_command_for_processes)"
    if [ "$best_command_for_processes" == "ss" ]; then
        echo "  Great choice! ss is the modern standard."
    fi
else
    echo "❌ best_command_for_processes incorrect. Should be ss, netstat, or lsof."
    errors=$((errors + 1))
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 Outstanding network analysis skills!"
    echo ""
    echo "You now understand:"
    echo "• Connection states (LISTEN, ESTAB, etc.)"
    echo "• How to monitor active connections"
    echo "• Tools for network diagnostics"
    echo ""
    echo "Ready for Kubernetes Services in Step 4!"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s)"
    echo ""
    echo "💡 Review:"
    echo "  Idle server: LISTEN state"
    echo "  Active connection: ESTAB state"
    echo "  Use: ss -tln (listening) or ss -tn (all connections)"
    exit 1
fi
