#!/bin/bash

echo "[A] Initializing UFW rules"

ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw --force enable

echo "[A] UFW status:"
ufw status verbose

exec /bin/bash

