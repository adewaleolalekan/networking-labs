# Step 4: Kubernetes Pod Network Challenge 🚀

Now let's apply your subnetting skills to a real Kubernetes scenario!

## The Scenario

You're setting up a Kubernetes cluster with this network configuration:
```yaml
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
networking:
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
```

## Pod Subnet Analysis

**Pod CIDR: 10.244.0.0/16**

This is the range where pod IPs will be assigned. Your cluster assigns each node a `/24` subnet from this larger `/16` range.

Example node allocation:
- Node 1: 10.244.0.0/24
- Node 2: 10.244.1.0/24
- Node 3: 10.244.2.0/24
- ...and so on

## Your Tasks

### Task A: Calculate Pod Subnet Capacity

For the **pod subnet 10.244.0.0/16**, calculate:

Create `/root/lab1/step4-pod-answers.txt`:
```
total_pod_ips=
first_pod_ip=
last_pod_ip=
```

### Task B: Calculate Per-Node Capacity

If each node gets a `/24` subnet, calculate:

Create `/root/lab1/step4-node-answers.txt`:
```
pods_per_node=
max_nodes=
```

Hints for Task B:
- Each `/24` has 254 usable IPs (pods per node)
- How many `/24` subnets fit in a `/16`? Think: 2^(24-16) = 2^8 = 256 possible node subnets

### Task C: Service Subnet (Bonus)

For the **service subnet 10.96.0.0/12**, calculate:

Create `/root/lab1/step4-service-answers.txt`:
```
total_service_ips=
max_services=
```

## Verification Commands
```bash
# Calculate pod subnet
ipcalc 10.244.0.0/16

# Calculate per-node capacity
ipcalc 10.244.0.0/24

# Calculate service subnet
ipcalc 10.96.0.0/12
```

## Real-World Context

Understanding these numbers helps you:
- Size your cluster appropriately
- Plan for growth
- Troubleshoot networking issues
- Avoid IP exhaustion

In production, you might see warnings like:
```
Warning: Node has allocated 250/254 pod IPs
```

Now you know exactly what that means!

Click **Check** when all three files are ready!