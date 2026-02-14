# Step 2: Calculate **192.168.1.0/24**

Now that you understand CIDR notation, let’s calculate the key values for this subnet:

**CIDR:** `192.168.1.0/24`

## What to Calculate

For this `/24` network, determine:

- Network address  
- Broadcast address  
- First usable host IP  
- Last usable host IP  
- Number of usable hosts  

## Use the Tools

Run:
```bash
ipcalc 192.168.1.0/24
# or
sipcalc 192.168.1.0/24
```

## Your Task

Create the file: `/root/lab1/step2-answers.txt`

It must contain these variables (exact names):

```
network_address=
broadcast_address=
first_usable=
last_usable=
usable_hosts=
```

### Example (do not copy blindly—verify your values)
```bash
cat > /root/lab1/step2-answers.txt << 'EOF'
network_address=192.168.0.0
broadcast_address=192.168.0.255
first_usable=192.168.0.1
last_usable=192.168.0.254
usable_hosts=254
EOF
```

## Quick Hints

- `/24` → host bits = 8 → total addresses = 2^8 = 256  
- Usable hosts = total - 2 (network + broadcast)  
- For a `.0/24` network:
  - Network ends in `.0`
  - Broadcast ends in `.255`

Click **Check** when ready.
