# 📖 Project Wiki: Technical Documentation & Verification
This wiki provides a detailed technical breakdown of the UFW ICMP Lab and logs the verification process.

## 🏰 Firewall Strategy
The core of this lab is demonstrating the difference between **Ingress** (Incoming) and **Egress** (Outgoing) filtering.

### ufw-A (Standard Node)
- **Policy**: Default deny incoming.
- **Functionality**: Serves as a target for testing incoming connectivity.

### ufw-B (Restricted Node)
- **Policy**: Default allow outgoing, with surgical egress blocks.
- **Surgical Strike**: Blocks outgoing ICMP `echo-request` to `ufw-A`. This means `ufw-B` can still receive pings, but it cannot originate them towards `ufw-A`.

---

## ✅ Verification Log (2026-01-14)
The following logs document the final verification of the network policies.

### 🔍 Issue Identified
Initial testing showed that `ufw-B` could still ping `ufw-A`. Upon inspection of `entrypoint-B.sh`:
```bash
# INCORRECT RULE (INITIAL)
-A ufw-before-input -p icmp --icmp-type echo-request -s 172.30.0.3 -d 172.30.0.2 -j DROP
```
The rule was placed in the `input` chain with a source IP of itself, which is ineffective for blocking outgoing traffic originating from the local host.

### 🛠️ Resolution
The rule was moved to the `output` chain to intercept packets before they depart the container:
```bash
# CORRECTED RULE
-A ufw-before-output -p icmp --icmp-type echo-request -d 172.30.0.2 -j DROP
```

### 📊 Test Results
| Test ID | Source | Target | Expectation | Result |
| :--- | :--- | :--- | :--- | :--- |
| **LAB-01** | `ufw-A` | `ufw-B` | ✅ Success | **PASSED** |
| **LAB-02** | `ufw-B` | `ufw-A` | ❌ Blocked | **PASSED** |

#### Test LAB-01: Ingress Check on B
```bash
docker exec ufw-A ping -c 3 172.30.0.3
PING 172.30.0.3 (172.30.0.3) 56(84) bytes of data.
64 bytes from 172.30.0.3: icmp_seq=1 ttl=64 time=0.267 ms
64 bytes from 172.30.0.3: icmp_seq=2 ttl=64 time=0.090 ms
64 bytes from 172.30.0.3: icmp_seq=3 ttl=64 time=0.096 ms

--- 172.30.0.3 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2032ms
```

#### Test LAB-02: Egress Check on B
```bash
docker exec ufw-B ping -c 3 172.30.0.2
PING 172.30.0.2 (172.30.0.2) 56(84) bytes of data.

--- 172.30.0.2 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2086ms
```

---
**Documentation maintained by Antigravity** 🚀
