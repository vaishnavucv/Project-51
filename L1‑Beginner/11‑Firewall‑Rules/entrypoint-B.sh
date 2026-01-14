#!/bin/bash

echo "[B] Initializing UFW rules"

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# Inject ICMP rule before UFW loads
sed -i '/^COMMIT/i \
# Block ICMP echo-request from B to A\n\
-A ufw-before-output -p icmp --icmp-type echo-request -d 172.30.0.2 -j DROP\n' /etc/ufw/before.rules

ufw --force enable

echo "[B] UFW status:"
ufw status verbose

exec /bin/bash

