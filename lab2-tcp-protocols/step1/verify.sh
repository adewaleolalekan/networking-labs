#!/bin/bash

# Wait for setup to complete
while [ ! -f /tmp/setup-complete ]; do
    sleep 1
done

# Check if answer file exists
if [ ! -f /root/lab2/step1-answers.txt ]; then
    echo "❌ File not found: /root/lab2/step1-answers.txt"
    echo "Please create the file with your answers."
    exit 1
fi

# Source the answers
source /root/lab2/step1-answers.txt

# Validate answers
errors=0

# Protocol choices
if [ "$web_browsing" != "TCP" ]; then
    echo "❌ web_browsing incorrect. HTTP uses TCP for reliability."
    errors=$((errors + 1))
else
    echo "✓ web_browsing correct (TCP)"
fi

if [ "$dns_lookup" != "UDP" ]; then
    echo "❌ dns_lookup incorrect. DNS uses UDP for speed (can retry if needed)."
    errors=$((errors + 1))
else
    echo "✓ dns_lookup correct (UDP)"
fi

if [ "$video_streaming" != "UDP" ]; then
    echo "❌ video_streaming incorrect. Streaming uses UDP (a few lost frames are OK)."
    errors=$((errors + 1))
else
    echo "✓ video_streaming correct (UDP)"
fi

if [ "$ssh_connection" != "TCP" ]; then
    echo "❌ ssh_connection incorrect. SSH needs TCP for reliable, ordered delivery."
    errors=$((errors + 1))
else
    echo "✓ ssh_connection correct (TCP)"
fi

if [ "$database_query" != "TCP" ]; then
    echo "❌ database_query incorrect. Databases use TCP to ensure data integrity."
    errors=$((errors + 1))
else
    echo "✓ database_query correct (TCP)"
fi

# True/False questions
if [ "$tcp_guarantees_delivery" != "true" ]; then
    echo "❌ tcp_guarantees_delivery incorrect. TCP guarantees delivery through ACKs."
    errors=$((errors + 1))
else
    echo "✓ tcp_guarantees_delivery correct (true)"
fi

if [ "$udp_is_faster" != "true" ]; then
    echo "❌ udp_is_faster incorrect. UDP is faster due to less overhead."
    errors=$((errors + 1))
else
    echo "✓ udp_is_faster correct (true)"
fi

if [ "$tcp_requires_handshake" != "true" ]; then
    echo "❌ tcp_requires_handshake incorrect. TCP uses 3-way handshake."
    errors=$((errors + 1))
else
    echo "✓ tcp_requires_handshake correct (true)"
fi

if [ "$udp_is_ordered" != "false" ]; then
    echo "❌ udp_is_ordered incorrect. UDP doesn't guarantee packet order."
    errors=$((errors + 1))
else
    echo "✓ udp_is_ordered correct (false)"
fi

# Final result
if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 Perfect! You understand TCP and UDP!"
    echo ""
    echo "Key Takeaways:"
    echo "• TCP = Reliable, ordered, connection-based"
    echo "• UDP = Fast, connectionless, best-effort"
    echo "• Choose based on your application's needs"
    exit 0
else
    echo ""
    echo "⚠️  Found $errors error(s). Review the concepts and try again."
    echo ""
    echo "💡 Remember:"
    echo "• TCP for accuracy (web, email, files, SSH)"
    echo "• UDP for speed (DNS, streaming, gaming)"
    exit 1
fi
