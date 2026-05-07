# Base image
FROM ubuntu:22.04

# Disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install SSH Server aur zaroori tools
RUN apt-get update && \
    apt-get install -y sudo openssh-server wget curl p7zip-full python3 python3-pip nano && \
    apt-get clean

# 2. SSH daemon ke chalne ke liye zaroori folder aur KEYS generate karna (Ye line sabse important hai)
RUN mkdir -p /var/run/sshd && ssh-keygen -A

# 3. Create user (Username: jeet, Password: password123)
RUN useradd -m -s /bin/bash jeet && \
    echo "jeet:password123" | chpasswd && \
    usermod -aG sudo jeet

# 4. SSH configuration ko update karna (Password se login allow karna)
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 5. SSH Port 22 Expose karein
EXPOSE 22

# 6. SSH server ko foreground me chalayein (Ye container ko zinda rakhega)
CMD ["/usr/sbin/sshd", "-D"]
