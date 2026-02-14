# Step 1: Understanding TCP and UDP

## The Transport Layer

TCP and UDP are Layer 4 (Transport Layer) protocols that handle how data is delivered between applications.

## TCP (Transmission Control Protocol)

**Characteristics:**
- **Connection-oriented**: Establishes a connection before sending data
- **Reliable**: Guarantees delivery, retransmits lost packets
- **Ordered**: Data arrives in the same order it was sent
- **Error-checked**: Detects and corrects errors
- **Slower**: More overhead due to reliability features

**3-Way Handshake:**
```
Client                    Server
  |                          |
  |-------- SYN ------------>|  (Client: "Let's connect")
  |                          |
  |<----- SYN-ACK -----------|  (Server: "OK, ready")
  |                          |
  |-------- ACK ------------>|  (Client: "Acknowledged")
  |                          |
  [Connection Established]
```

**When to use TCP:**
- Web browsing (HTTP/HTTPS)
- Email (SMTP, IMAP)
- File transfers (FTP, SSH)
- Database connections
- Any time data integrity is critical

## UDP (User Datagram Protocol)

**Characteristics:**
- **Connectionless**: No connection setup, just send
- **Unreliable**: No delivery guarantee, packets can be lost
- **Unordered**: Packets may arrive out of order
- **No error correction**: Faster but less reliable
- **Lower overhead**: Ideal for real-time applications

**How it works:**
```
Client                    Server
  |                          |
  |------- Datagram -------->|  (Just send it!)
  |------- Datagram -------->|
  |------- Datagram -------->|
  |                          |
  (No acknowledgment required)
```

**When to use UDP:**
- DNS lookups (speed matters, can retry if needed)
- Video streaming (a few lost frames are OK)
- Gaming (real-time, slight data loss acceptable)
- VoIP (voice calls)
- Broadcasting/multicasting

## Comparing TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| Connection | Required | Not required |
| Reliability | Guaranteed delivery | Best effort |
| Speed | Slower | Faster |
| Overhead | Higher | Lower |
| Use case | Accuracy critical | Speed critical |
| Examples | HTTP, SSH, FTP | DNS, Video, Gaming |

## Ports Explained

**Port numbers** identify specific applications or services on a host.

**Port Ranges:**
- **0-1023**: Well-known ports (HTTP=80, HTTPS=443, SSH=22)
- **1024-49151**: Registered ports (MySQL=3306, PostgreSQL=5432)
- **49152-65535**: Dynamic/Private ports (temporary client connections)

**Example:**
```
When you visit http://example.com:80
- example.com = IP address (where to go)
- :80 = Port number (which service on that machine)
- Protocol: TCP (HTTP uses TCP)
```

## View Common Ports

Run this command to see common port assignments:
```bash
common-ports
```

## Your Task

Demonstrate your understanding by answering questions about TCP and UDP.

Create `/root/lab2/step1-answers.txt` with these answers:
```
# Which protocol (TCP or UDP) would you use for:
web_browsing=
dns_lookup=
video_streaming=
ssh_connection=
database_query=

# True or False
tcp_guarantees_delivery=
udp_is_faster=
tcp_requires_handshake=
udp_is_ordered=
```

**Hint:** Think about whether each use case prioritizes reliability or speed.

**Example:**
```bash
cat > /root/lab2/step1-answers.txt << EOF
web_browsing=TCP
dns_lookup=UDP
video_streaming=UDP
ssh_connection=TCP
database_query=TCP
tcp_guarantees_delivery=true
udp_is_faster=true
tcp_requires_handshake=true
udp_is_ordered=false
EOF
```

When ready, click **Check** to verify your answers!
