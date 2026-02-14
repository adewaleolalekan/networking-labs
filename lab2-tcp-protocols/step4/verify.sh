#!/bin/bash

# Check if answer file exists
if [ ! -f /root/lab2/step4-answers.txt ]; then
    echo "❌ File not found: /root/lab2/step4-answers.txt"
    exit 1
fi

# Source the answers
source /root/lab2/step4-answers.txt

errors=0

# Scenario 1: Web App
echo "Checking Scenario 1 (Web App)..."

if [ "$webapp_type" != "NodePort" ]; then
    echo "❌ webapp_type incorrect. Need external access = NodePort"
    errors=$((errors + 1))
else
    echo "✓ webapp_type correct (NodePort)"
fi

if [ "$webapp_port" != "80" ]; then
    echo "❌ webapp_port incorrect. Standard HTTP port is 80"
    errors=$((errors + 1))
else
    echo "✓ webapp_port correct (80)"
fi

if [ "$webapp_targetport" != "3000" ]; then
    echo "❌ webapp_targetport incorrect. App listens on 3000"
    errors=$((errors + 1))
else
    echo "✓ webapp_targetport correct (3000)"
fi

if [ "$webapp_nodeport" -lt 30000 ] || [ "$webapp_nodeport" -gt 32767 ]; then
    echo "❌ webapp_nodeport out of range. Must be 30000-32767"
    errors=$((errors + 1))
else
    echo "✓ webapp_nodeport in valid range ($webapp_nodeport)"
fi

if [ "$webapp_protocol" != "TCP" ]; then
    echo "❌ webapp_protocol incorrect. HTTP uses TCP"
    errors=$((errors + 1))
else
    echo "✓ webapp_protocol correct (TCP)"
fi

# Scenario 2: Database
echo ""
echo "Checking Scenario 2 (Database)..."

if [ "$database_type" != "ClusterIP" ]; then
    echo "❌ database_type incorrect. Internal only = ClusterIP"
    errors=$((errors + 1))
else
    echo "✓ database_type correct (ClusterIP)"
fi

if [ "$database_port" != "5432" ]; then
    echo "❌ database_port incorrect. PostgreSQL default is 5432"
    errors=$((errors + 1))
else
    echo "✓ database_port correct (5432)"
fi

if [ "$database_protocol" != "TCP" ]; then
    echo "❌ database_protocol incorrect. Databases use TCP"
    errors=$((errors + 1))
else
    echo "✓ database_protocol correct (TCP)"
fi

# Scenario 3: DNS
echo ""
echo "Checking Scenario 3 (DNS)..."

if [[ ! "$dns_protocols" =~ TCP.*UDP ]] && [[ ! "$dns_protocols" =~ UDP.*TCP ]]; then
    echo "❌ dns_protocols incorrect. DNS needs both TCP and UDP"
    errors=$((errors + 1))
else
    echo "✓ dns_protocols correct (both TCP and UDP)"
fi

if [ "$dns_port" != "53" ]; then
    echo "❌ dns_port incorrect. DNS uses port 53"
    errors=$((errors + 1))
else
    echo "✓ dns_port correct (53)"
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉🎉🎉 EXCELLENT WORK! 🎉🎉🎉"
    echo ""
    echo "You've mastered Kubernetes Services and ports!"
    echo ""
    echo "Key Concepts You've Learned:"
    echo "├─ Service Types:"
    echo "│  • ClusterIP: Internal access only"
    echo "│  • NodePort: External access via node IP"
    echo "│  • LoadBalancer: Cloud-managed external IP"
    echo "├─ Port Mappings:"
    echo "│  • port: Service port (ClusterIP)"
    echo "│  • targetPort: Container port"
    echo "│  • nodePort: External port (30000-32767)"
    echo "└─ Protocols:"
    echo "   • TCP: Most applications"
    echo "   • UDP: DNS, streaming, gaming"
    echo ""
    echo "These skills are fundamental for:"
    echo "• Exposing applications in Kubernetes"
    echo "• Troubleshooting connectivity"
    echo "• Designing microservices"
    echo "• Security configuration"
    echo ""
    echo "Ready for Lab 3: DNS Fundamentals! 🚀"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s)"
    echo ""
    echo "💡 Review:"
    echo "• ClusterIP = internal only"
    echo "• NodePort = external access (30000-32767)"
    echo "• targetPort = where container listens"
    echo "• port = service port"
    echo "• TCP for most apps, UDP for DNS/streaming"
    exit 1
fi
