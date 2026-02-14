# Step 1: Understanding CIDR Notation

## Background

Before we calculate subnets, let's understand what CIDR notation means.

**CIDR Format:** `IP_ADDRESS/PREFIX_LENGTH`

Example: `192.168.1.0/24`
- `/24` means the first 24 bits identify the network
- Remaining 8 bits (32 - 24) are for hosts
- This gives us 2^8 = 256 total addresses
- Usable hosts = 256 - 2 = 254 (subtract network and broadcast)

## Try the Tools

Run these commands to see how the tools work:
```bash
# Basic usage
ipcalc 192.168.1.0/24

# Alternative tool with different format
sipcalc 192.168.1.0/24
```

## Your Task

Examine the output from `ipcalc` and answer these questions by creating a file.

Create `/root/lab1/step1-answers.txt` with the following information about `192.168.1.0/24`:
```
network_bits=
host_bits=
total_addresses=
```

**Hints:**
- Network bits = the number after the `/`
- Host bits = 32 - network bits
- Total addresses = 2^host_bits

**Example file creation:**
```bash
cat > /root/lab1/step1-answers.txt << EOF
network_bits=24
host_bits=8
total_addresses=256
EOF
```

When ready, click **Check** to verify your answer.