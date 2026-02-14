# Step 2: Port Scanning and Service Detection

## Understanding Port States

When scanning ports, they can be in different states:

**Open**: A service is listening and accepting connections
**Closed**: Nothing is listening on that port
**Filtered**: A firewall is blocking access (can't determine if open/closed)

## Using Netcat (nc)

Netcat is the "Swiss Army knife" of networking. It can:
- Test if a port is open
- Create simple servers
- Transfer files
- Debug network connections

### Basic Port Check
```bash
# Check if port 80 is open on a server
nc -zv example.com 80

# Flags:
# -z  Zero I/O mode (just check, don't send data)
# -v  Verbose (show what's happening)
```

### Scan Multiple Ports
```bash
# Scan ports 20-25
nc -zv example.com 20-25

# Scan specific ports
nc -zv example.com 22 80 443
```

## Try It: Scan Common Ports

Let's scan some common ports on localhost:
```bash
# Scan ports 20-100 on localhost
nc -zv localhost 20-100 2>&1 | grep succeeded
```

## Using lsof to See Open Ports

The `lsof` command shows which processes are using which ports:
```bash
# Show all listening TCP ports
sudo lsof -i TCP -s TCP:LISTEN

# Show what's using port 22 (SSH)
sudo lsof -i :22

# Show all network connections
sudo lsof -i
```

## Using ss (Socket Statistics)

`ss` is the modern replacement for netstat:
```bash
# Show all listening TCP ports
ss -tlnp

# Flags:
# -t  TCP sockets
# -l  Listening sockets
# -n  Show numbers (don't resolve names)
# -p  Show process using the socket

# Show all listening UDP ports
ss -ulnp

# Show all established connections
ss -tnp
```

## Common Services and Their Ports

Here are services you'll commonly see:

| Service | Port | Protocol | Description |
|---------|------|----------|-------------|
| SSH | 22 | TCP | Secure shell |
| HTTP | 80 | TCP | Web traffic |
| HTTPS | 443 | TCP | Secure web |
| DNS | 53 | UDP/TCP | Domain lookup |
| SMTP | 25 | TCP | Email |
| MySQL | 3306 | TCP | Database |

## Your Task: Service Detection

We've started some services in the background. Your job is to identify them!

**Use these commands to investigate:**
```bash
# See what's listening
ss -tlnp

# Or use lsof
sudo lsof -i TCP -s TCP:LISTEN

# Test specific ports
nc -zv localhost 8080
```

**Create `/root/lab2/step2-answers.txt` with your findings:**
```
# What port is the Python HTTP server listening on?
http_server_port=

# Is port 22 (SSH) listening? (yes/no)
ssh_listening=

# How many TCP listening ports are there? (number)
tcp_listening_count=
```

**Hints:**
- Look for python3 in the process list
- SSH daemon (sshd) should be running
- Count lines from: `ss -tlnp | grep LISTEN | wc -l`

**Example solution process:**
```bash
# Find listening ports
ss -tlnp

# Look for Python server (should be on 8080)
# Look for sshd (should be on 22)
# Count listening ports

# Create answer file
cat > /root/lab2/step2-answers.txt << EOF
http_server_port=8080
ssh_listening=yes
tcp_listening_count=3
EOF
```

Click **Check** when ready!
