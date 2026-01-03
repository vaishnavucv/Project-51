# 🍯 Project 01: Honeypot Setup

Welcome to the **Honeypot Setup** lab. This project focuses on creating an early warning system designed to detect, deflect, or in some manner counteract attempts at unauthorized use of information systems.

<div align="center">
<img src="https://github.com/user-attachments/assets/c4ad6f4f-adc4-4d15-a3b8-743bdd9d6154" width="80">
</div>

## 📖 Overview
A honeypot is a security mechanism that sets a virtual trap to lure attackers. An intentionally compromised computer system allows attackers to exploit vulnerabilities so you can study them to improve your security policies.

### **Learning Objectives**
- Understand the difference between Low-Interaction and High-Interaction honeypots.
- Configure a basic honeypot system (e.g., Cowrie, Pentbox, or a custom script).
- Monitor and analyze incoming attack logs.
- Implement alerting mechanisms for real-time detection.

---

## 🛠️ Lab Setup
### **Requirements**
- **OS**: Linux (Ubuntu recommended)
- **Tools**: `python3`, `docker` (optional for isolation)
- **Network**: Isolated subnet or a VPS with restricted access.

### **Quick Start (Simulation)**
1.  **Clone the Lab Assets**:
    ```bash
    git clone https://github.com/vaishnavucv/Projects-51.git
    cd Projects-51/L1‑Beginner/01‑Honeypot‑Setup
    ```
2.  **Run the Simulation**:
    *(Stay tuned for the official lab scripts!)*

---

## 📊 Analysis & Reporting
Every honeypot lab should conclude with an analysis of the "captured" data:
| Metric | Description |
| :--- | :--- |
| **Source IP** | Origin of the attack. |
| **Target Port** | The service they tried to exploit (SSH, Telnet, HTTP). |
| **Payloads** | Any scripts or commands executed by the attacker. |
| **Timestamps** | Frequency and duration of the interaction. |

---

## 🛡️ Best Practices
- **Isolation**: Always run honeypots in a segregated network to prevent lateral movement.
- **Monitoring**: Use a separate logging server so attackers cannot delete their tracks.
- **Ethical Use**: Ensure you have permission if deploying on a network you don't own.

---

## 🔗 Resources
- 📚 [Honeynet Project](https://www.honeynet.org/)
- 🛠️ [Cowrie Honeypot Documentation](https://github.com/cowrie/cowrie)

---

<div align="center">
**Part of [Project-51](https://github.com/vaishnavucv/Projects-51)**
</div>
