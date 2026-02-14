# Step 4: Kubernetes Services and Ports

Now let's apply everything you've learned to Kubernetes!

## Kubernetes Service Types and Ports

### Service Types

**ClusterIP** (default):
- Internal IP only
- Accessible only within the cluster
- Port: Chosen by you (e.g., 80, 443, 8080)

**NodePort**:
- Exposes service on each node's IP
- Port range: 30000-32767
- Accessible from outside cluster via Node IP

**LoadBalancer**:
- Cloud provider creates external load balancer
- Assigns external IP
- Routes to NodePort, then to ClusterIP

## How Kubernetes Services Use Ports

A Kubernetes Service has multiple port concepts:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  ports:
  - port: 80           # ClusterIP port (internal)
    targetPort: 8080   # Pod port (where app listens)
    nodePort: 30080    # NodePort (external access)
    protocol: TCP      # TCP or UDP
```

**Port Mapping Flow:**
```
External Request
    ↓
NodePort (30080) → Service Port (80) → TargetPort (8080)
    ↓                    ↓                    ↓
On Node IP        ClusterIP          Pod Container
```

## Example: Web Application Service

Imagine you have a web app running in a pod:
- The app container listens on port 8080
- You want to expose it on standard HTTP port 80
- You want external access via NodePort 30080
```yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
  - name: http
    protocol: TCP
    port: 80          # Service port (ClusterIP)
    targetPort: 8080  # Container port
    nodePort: 30080   # External port
```

**Traffic flow:**
```
User → http://node-ip:30080 → Service (ClusterIP:80) → Pod (8080)
```

## Protocol Selection: TCP vs UDP

Most Kubernetes services use TCP, but UDP is supported:

**TCP Services (common):**
- Web applications (HTTP/HTTPS)
- Databases
- REST APIs
- gRPC

**UDP Services (less common):**
- DNS
- syslog
- Some gaming servers
- Video streaming

**Example UDP Service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: dns-service
spec:
  ports:
  - port: 53
    targetPort: 53
    protocol: UDP  # Note: UDP instead of TCP
```

## Common Kubernetes Ports

| Component | Port | Protocol | Purpose |
|-----------|------|----------|---------|
| API Server | 6443 | TCP | Kubernetes API |
| etcd | 2379-2380 | TCP | Key-value store |
| kubelet | 10250 | TCP | Node agent |
| kube-proxy | 10256 | TCP | Network proxy |
| NodePort range | 30000-32767 | TCP/UDP | External access |

## Multi-Port Services

Services can expose multiple ports:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: multi-port-service
spec:
  ports:
  - name: http
    port: 80
    targetPort: 8080
    protocol: TCP
  - name: https
    port: 443
    targetPort: 8443
    protocol: TCP
  - name: metrics
    port: 9090
    targetPort: 9090
    protocol: TCP
```

## Your Task: Kubernetes Service Configuration

Design Kubernetes Services based on requirements.

**Scenario 1: Simple Web App**

Requirements:
- App listens on port 3000
- Want to expose on standard HTTP port (80)
- Need external access via NodePort
- Use TCP protocol

**Scenario 2: Database Service**

Requirements:
- PostgreSQL listens on port 5432
- Only need internal cluster access (ClusterIP)
- Use TCP protocol

**Scenario 3: DNS Service**

Requirements:
- DNS server listens on port 53
- Needs both TCP and UDP
- Internal access only

**Create `/root/lab2/step4-answers.txt`:**
```
# Scenario 1: Web App
webapp_type=           # Service type (ClusterIP/NodePort/LoadBalancer)
webapp_port=           # Service port (what clients connect to)
webapp_targetport=     # Container port (where app listens)
webapp_nodeport=       # NodePort (30000-32767 range)
webapp_protocol=       # TCP or UDP

# Scenario 2: Database
database_type=         # Service type
database_port=         # Service port
database_protocol=     # TCP or UDP

# Scenario 3: DNS
dns_protocols=         # Both protocols needed (comma-separated: TCP,UDP)
dns_port=              # Port number
```

**Example answers:**
```bash
cat > /root/lab2/step4-answers.txt << EOF
# Scenario 1: Web App
webapp_type=NodePort
webapp_port=80
webapp_targetport=3000
webapp_nodeport=30080
webapp_protocol=TCP

# Scenario 2: Database
database_type=ClusterIP
database_port=5432
database_protocol=TCP

# Scenario 3: DNS
dns_protocols=TCP,UDP
dns_port=53
EOF
```

**Hints:**
- NodePort range: 30000-32767
- ClusterIP for internal-only access
- Database shouldn't be exposed externally
- DNS uses both TCP and UDP

Click **Check** when ready!
