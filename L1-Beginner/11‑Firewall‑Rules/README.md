# 🛡️ UFW ICMP Lab: Network Isolation & Firewall Control

![UFW Lab Banner](https://raw.githubusercontent.com/vaishnavucv/ufw-icmp-lab/main/assets/banner.png) *(Note: Placeholder link for banner)*

## 📖 Introduction
UFW (Uncomplicated Firewall) ICMP Lab is a specialized Docker-based environment designed to demonstrate advanced network traffic control using 🏰 **UFW**. This project illustrates how to configure firewall rules to selectively allow or block ICMP (Ping) traffic between isolated containers, showcasing both ingress and egress filtering techniques.

For a deep dive into the technical implementation, check out the [Full Project Documentation (Wiki)](./wiki.md).

---

## 🚀 What is this project?
This project sets up a controlled network environment with two Ubuntu-based containers:
- **ufw-A**: A secure node with standard firewall policies.
- **ufw-B**: A policy-restricted node that can't reach ufw-A via ICMP but can be reached by others.

### 🔥 Core Features:
- **Dockerized Environment**: Fully containerized using `docker-compose`.
- **Dynamic Rule Injection**: Uses shell scripts to inject low-level `iptables` rules via UFW's `before.rules`.
- **Network Isolation**: Custom bridge network with static IP assignment.
- **Automated Setup**: Instant firewall configuration upon container startup.

---

## 🛠️ How it Works
The lab uses a custom **Dockerfile** based on Ubuntu 22.04 with UFW pre-installed. Upon deployment, each container executes a specific entrypoint script:

1.  **Container A**: Initializes UFW with a "Default Deny Incoming" and "Default Allow Outgoing" policy.
2.  **Container B**: Aside from standard policies, it performs a **surgical strike** on egress ICMP traffic. It modifies `/etc/ufw/before.rules` to drop any outgoing ICMP `echo-requests` specifically targeting Container A's IP.

---

## 📊 Scenario & Architecture

### Network Topology
- **Subnet**: `172.30.0.0/24`
- **ufw-A (Node A)**: `172.30.0.2`
- **ufw-B (Node B)**: `172.30.0.3`

### Connectivity Matrix
| Source | Destination | Action | Reason |
| :--- | :--- | :--- | :--- |
| `ufw-A` | `ufw-B` | ✅ **Success** | Node A allows outgoing; Node B allows incoming (by default ufw rules). |
| `ufw-B` | `ufw-A` | ❌ **Blocked** | Node B has an explicit **Egress DROP** rule for Node A's IP. |

---

## 💻 Docker Image & Compose
The environment is orchestrated using `docker-compose.yml`.

### Dockerfile Highlights
- Base: `ubuntu:22.04`
- 📦 Installed Tools: `ufw`, `iputils-ping`, `iproute2`, `net-tools`.
- ⚙️ IPv6 disabled in UFW to focus on IPv4 ICMP.

### Docker Compose
Executes two services with `privileged: true` (required for UFW to interact with the kernel's netfilter).

---

## 🚦 How to Use the Project

### 1. Requirements
- Docker & Docker Compose installed.

### 2. Launch the Lab
```bash
docker-compose up -d --build
```

### 3. Verify Container Status
Check if both containers are running:
```bash
docker ps
```

### 4. Execute the Tests

#### Test 1: Ping from A to B (Expected: Success)
```bash
docker exec -it ufw-A ping -c 4 172.30.0.3
```

#### Test 2: Ping from B to A (Expected: Blocked)
```bash
docker exec -it ufw-B ping -c 4 172.30.0.2
```

---

## 📜 Status & Scripts

### Entrypoint Scripts
- `entrypoint-A.sh`: Resets UFW and enables standard protection.
- `entrypoint-B.sh`: Injects the custom ICMP block rule and enables UFW.

### Check Firewall Status
```bash
# Check Node A
docker exec -it ufw-A ufw status verbose

# Check Node B
docker exec -it ufw-B ufw status verbose
```

---

## 🌟 Visualizing the Blockage
When you run the ping from B to A, you will notice the output hangs or returns `Operation not permitted` / `Packet filtered`. This confirms that the **Egress Rule** in `ufw-B` is successfully dropping the packets before they even leave the container!

---

Part of the **[Project-51](../../README.md)** portfolio.
