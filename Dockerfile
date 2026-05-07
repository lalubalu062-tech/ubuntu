# Base image
FROM ubuntu:22.04

# Disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install SSH Server aur zaroori tools (Wine/Chrome hata diya)
RUN apt-get update && \
    apt-get install -y sudo openssh-server wget curl p7zip-full python3 python3-pip nano && \
    apt-get clean

# SSH daemon ke chalne ke liye zaroori folder
RUN mkdir /var/run/sshd

# 2. Create user (Username: jeet, Password: password123)
RUN useradd -m -s /bin/bash jeet && \
    echo "jeet:password123" | chpasswd && \
    usermod -aG sudo jeet

# 3. Termius me password se login karne ke liye SSH configuration update karein
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 4. SSH Port 22 Expose karein
EXPOSE 22

# 5. SSH server ko foreground me chalayein (Ye container ko 24/7 zinda rakhega)
CMD ["/usr/sbin/sshd", "-D"]
