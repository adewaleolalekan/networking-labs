#!/bin/bash

errors=0

# Task A: Pod Subnet
if [ ! -f /root/lab1/step4-pod-answers.txt ]; then
    echo "❌ Missing: /root/lab1/step4-pod-answers.txt"
    errors=$((errors + 1))
else
    source /root/lab1/step4-pod-answers.txt
    
    # /16 has 2^16 = 65536 addresses, minus 2 = 65534
    if [ "$total_pod_ips" != "65534" ]; then
        echo "❌ total_pod_ips incorrect. Expected: 65534"
        echo "   Hint: /16 means 16 host bits, so 2^16 - 2"
        errors=$((errors + 1))
    else
        echo "✓ total_pod_ips correct"
    fi
    
    if [ "$first_pod_ip" != "10.244.0.1" ]; then
        echo "❌ first_pod_ip incorrect. Expected: 10.244.0.1"
        errors=$((errors + 1))
    else
        echo "✓ first_pod_ip correct"
    fi
    
    if [ "$last_pod_ip" != "10.244.255.254" ]; then
        echo "❌ last_pod_ip incorrect. Expected: 10.244.255.254"
        errors=$((errors + 1))
    else
        echo "✓ last_pod_ip correct"
    fi
fi

# Task B: Node Capacity
if [ ! -f /root/lab1/step4-node-answers.txt ]; then
    echo "❌ Missing: /root/lab1/step4-node-answers.txt"
    errors=$((errors + 1))
else
    source /root/lab1/step4-node-answers.txt
    
    if [ "$pods_per_node" != "254" ]; then
        echo "❌ pods_per_node incorrect. Expected: 254"
        echo "   Hint: Each node gets /24, which has 254 usable IPs"
        errors=$((errors + 1))
    else
        echo "✓ pods_per_node correct"
    fi
    
    if [ "$max_nodes" != "256" ]; then
        echo "❌ max_nodes incorrect. Expected: 256"
        echo "   Hint: How many /24 subnets fit in /16? 2^(24-16) = 256"
        errors=$((errors + 1))
    else
        echo "✓ max_nodes correct"
    fi
fi

# Task C: Service Subnet
if [ ! -f /root/lab1/step4-service-answers.txt ]; then
    echo "❌ Missing: /root/lab1/step4-service-answers.txt"
    errors=$((errors + 1))
else
    source /root/lab1/step4-service-answers.txt
    
    # /12 has 2^20 = 1048576 addresses, minus 2 = 1048574
    if [ "$total_service_ips" != "1048576" ]; then
        echo "❌ total_service_ips incorrect. Expected: 1048576"
        echo "   Hint: /12 means 20 host bits (32-12), so 2^20"
        errors=$((errors + 1))
    else
        echo "✓ total_service_ips correct"
    fi
    
    if [ "$max_services" != "1048574" ]; then
        echo "❌ max_services incorrect. Expected: 1048574"
        echo "   Hint: Total IPs minus 2 (network + broadcast)"
        errors=$((errors + 1))
    else
        echo "✓ max_services correct"
    fi
fi

if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉🎉🎉 OUTSTANDING! 🎉🎉🎉"
    echo ""
    echo "You've successfully analyzed a Kubernetes network!"
    echo ""
    echo "Summary of your cluster:"
    echo "├─ Pod Network: 10.244.0.0/16"
    echo "│  └─ Can support up to 65,534 pods across 256 nodes"
    echo "│  └─ Each node gets 254 pod IPs"
    echo "└─ Service Network: 10.96.0.0/12"
    echo "   └─ Can create up to 1,048,574 services"
    echo ""
    echo "This knowledge will help you:"
    echo "• Design properly sized clusters"
    echo "• Understand cluster capacity limits"
    echo "• Troubleshoot networking issues"
    echo "• Plan for scale"
    echo ""
    echo "Ready for Lab 2? You've got this! 💪"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s)"
    echo ""
    echo "💡 Review Tips:"
    echo "• Use ipcalc for each subnet"
    echo "• Remember: usable IPs = total - 2"
    echo "• /16 to /24 = 256 subnets (2^8)"
    echo "• For /12: host bits = 32 - 12 = 20"
    exit 1
fi
