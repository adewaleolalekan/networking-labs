# Step 3: Analyzing Network Connections

## Understanding Network States

When analyzing connections, you'll see different states:

**TCP Connection States:**
- **LISTEN**: Waiting for incoming connections
- **ESTABLISHED**: Active connection
- **TIME_WAIT**: Connection closed, waiting to ensure remote received ACK
- **CLOSE_WAIT**: Remote side closed connection
- **SYN_SENT**: Attempting to establish connection
- **SYN_RECV**: Received connection request

## Using netstat

While `ss` is newer, `netstat` is still widely used:
```bash
# Show all connections
netstat -an

# Show listening ports
netstat -tuln

# Show connections with process info
netstat -tulnp

# Flags:
# -t  TCP
# -u  UDP
# -l  Listening
# -n  Numeric (don't resolve names)
# -p  Process
# -a  All (listening and non-listening)
```

## Using ss for Connection Analysis
```bash
# Show all TCP connections
ss -tan

# Show established connections only
ss -tan state established

# Show listening ports with process names
ss -tlnp

# Count connections by state
ss -tan | awk '{print $1}' | sort | uniq -c
```

## Testing Connections with Netcat

### Create a Simple Server
```bash
# In one terminal, start a listener
nc -l -p 9999

# In another terminal, connect to it
nc localhost 9999

# Type messages in either terminal - they appear in both!
# This shows a TCP connection in ESTABLISHED state
```

### Test HTTP Connection
```bash
# Connect to port 80 and send HTTP request
echo -e "GET / HTTP/1.0\n\n" | nc example.com 80

# Or use curl to see the response
curl -v http://localhost:8080
```

## Practical Exercise: Connection States

Let's explore different connection states:

### 1. Start a listener
```bash
# Open a listening port
nc -l -p 7777 &
echo $!  # Note the process ID
```

### 2. Check it's listening
```bash
ss -tlnp | grep 7777
# Should show LISTEN state
```

### 3. Connect to it
```bash
# In another command
nc localhost 7777 &

# Now check connections
ss -tn | grep 7777
# Should show ESTAB (established) state
```

### 4. Kill the connections
```bash
# Kill both netcat processes
killall nc

# Watch the states change
ss -tn | grep 7777
# May briefly show TIME_WAIT state
```

## Analyzing the Python HTTP Server

Remember the Python server from Step 2? Let's analyze its connections.

### Check the Server Status
```bash
# Is it listening?
ss -tlnp | grep 8080

# Test it with curl
curl http://localhost:8080

# See the connection
ss -tn | grep 8080
```

## Your Task: Connection Analysis

Perform connection analysis and answer questions.

**Part 1: Identify Connection States**
```bash
# Check current connections
ss -tan

# Connect to the HTTP server
curl http://localhost:8080 &

# Immediately check the connection state
ss -tn | grep 8080
```

**Part 2: Count Connections**
```bash
# How many ESTABLISHED connections?
ss -tan state established | wc -l

# How many LISTEN sockets?
ss -tln | wc -l
```

**Create `/root/lab2/step3-answers.txt`:**
```
# What state is port 8080 in when no one is connected? (LISTEN/ESTAB/CLOSED)
port_8080_idle_state=

# After running 'curl http://localhost:8080', what state does the connection show? (LISTEN/ESTAB/TIME-WAIT)
port_8080_active_state=

# How many total listening TCP sockets are there? (number)
listening_sockets=

# What command shows processes using network ports? (netstat/ss/lsof - choose one)
best_command_for_processes=
```

**Example:**
```bash
# Check idle state
ss -tln | grep 8080
# Should show LISTEN

# Make a connection and check
curl http://localhost:8080 &
ss -tn | grep 8080
# Should show ESTAB

# Count listening sockets
ss -tln | wc -l

# Create answers
cat > /root/lab2/step3-answers.txt << EOF
port_8080_idle_state=LISTEN
port_8080_active_state=ESTAB
listening_sockets=3
best_command_for_processes=ss
EOF
```

Click **Check** to verify!
