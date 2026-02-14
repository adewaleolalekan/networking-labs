# Congratulations! 🎊

You've completed Lab 1: CIDR Calculator Practice!

## What You've Mastered

✅ Understanding CIDR notation (prefix lengths)  
✅ Calculating network and broadcast addresses  
✅ Finding usable host ranges  
✅ Determining subnet capacity  
✅ Applying subnetting to Kubernetes networks  

## Key Takeaways

**Common CIDR Blocks:**
- `/8` = ~16 million IPs (Class A equivalent)
- `/16` = ~65,000 IPs (Class B equivalent)
- `/24` = 254 IPs (Class C equivalent)
- `/26` = 62 IPs (small subnet)
- `/30` = 2 IPs (point-to-point links)

**Formula to Remember:**
```
Host bits = 32 - prefix length
Total addresses = 2^(host bits)
Usable hosts = Total - 2
```

**In Kubernetes:**
- Pod CIDR: Usually /16 (provides room for growth)
- Service CIDR: Usually /12 or /16
- Per-node subnet: Usually /24 (254 pods per node)

## Quiz Yourself

Before moving on, can you answer these without looking?

1. How many usable IPs in a /25 subnet?
2. What's the broadcast address of 172.16.0.0/22?
3. Can 10.10.10.5/28 and 10.10.10.20/28 communicate directly?

<details>
<summary>Click to see answers</summary>

1. /25 = 7 host bits → 2^7 - 2 = 126 usable IPs
2. /22 = 10 host bits → 2^10 = 1024 addresses → Broadcast = 172.16.3.255
3. No! They're in different subnets:
   - 10.10.10.5/28 is in 10.10.10.0-15 range
   - 10.10.10.20/28 is in 10.10.10.16-31 range

</details>

## What's Next?

**Lab 2: TCP/IP & Protocols** will cover:
- Port scanning and service identification
- TCP vs UDP
- Network troubleshooting with netstat/ss

## Resources for Further Learning

- [Subnet Calculator Tool](https://www.subnet-calculator.com/)
- [Kubernetes Networking 101](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
- [RFC 4632 - CIDR Specification](https://tools.ietf.org/html/rfc4632)

## Feedback

Please rate this lab and let us know how we can improve!

**Keep practicing, and see you in Lab 2!** 🚀