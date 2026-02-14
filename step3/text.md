# Step 3: Smaller Subnet Challenge

Time to tackle a smaller subnet: **10.10.10.0/26**

## What's Different?

A `/26` subnet is smaller than `/24`:
- `/26` = 26 network bits, 6 host bits
- 2^6 = 64 total addresses
- Range spans: 10.10.10.0 through 10.10.10.63

## Calculation Strategy

For `/26`:
1. Find how many host bits: 32 - 26 = 6 bits
2. Calculate total addresses: 2^6 = 64
3. Address range: starts at base (.0), ends at base + 63
4. Network: 10.10.10.0
5. Broadcast: 10.10.10.63 (base + 63)
6. First usable: 10.10.10.1
7. Last usable: 10.10.10.62
8. Usable hosts: 64 - 2 = 62

## Your Task

Create `/root/lab1/step3-answers.txt`:
```
host_bits=
total_addresses=
network_address=
broadcast_address=
first_usable=
last_usable=
usable_hosts=
```

**Pro Tip:**
```bash
# Quick way to find the broadcast address:
# For /26: 2^6 = 64
# Broadcast = Network + (64 - 1) = Network + 63
# So: 10.10.10.0 + 63 = 10.10.10.63

# Verify with ipcalc:
ipcalc 10.10.10.0/26
```

**Common Mistake Alert! ⚠️**
Don't assume `/26` ends at `.255` like `/24` does!
The last octet only goes up to `.63` for this subnet.

Click **Check** when ready!