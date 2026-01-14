FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        ufw \
        iputils-ping \
        iproute2 \
        net-tools \
        nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Disable IPv6 to avoid ICMP confusion
RUN sed -i 's/IPV6=yes/IPV6=no/' /etc/default/ufw

# Copy entrypoints
COPY entrypoint-A.sh /entrypoint-A.sh
COPY entrypoint-B.sh /entrypoint-B.sh

RUN chmod +x /entrypoint-A.sh /entrypoint-B.sh

CMD ["/bin/bash"]

