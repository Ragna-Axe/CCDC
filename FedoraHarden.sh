#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or using sudo."
  exit 1
fi

# Update the system
dnf update -y

# Set strong passwords for all users (excluding root)
awk -F: '$3 >= 1000 && $1 != "root" {print $1}' /etc/passwd | xargs -I {} sudo chpasswd <<< "{}:ATCCccdc2025!" 

# Disable root login via SSH
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Configure SSH to allow only key-based authentication
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Install and configure a firewall (firewalld)
dnf install firewalld -y
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-service=ssh --permanent
firewall-cmd --reload

# Enable and configure automatic security updates
dnf install dnf-automatic -y
systemctl enable --now dnf-automatic.timer

# Disable unnecessary services
systemctl disable avahi-daemon
systemctl disable cups

# Remove unnecessary packages
dnf autoremove -y

# Disable unused network protocols
echo "install dccp /bin/true" > /etc/modprobe.d/disable-dccp.conf
echo "install sctp /bin/true" > /etc/modprobe.d/disable-sctp.conf

# Enable auditd for system auditing
dnf install audit -y
systemctl enable auditd
systemctl start auditd

# Set restrictive permissions on critical files and directories
chmod 0700 /root
chmod 0700 /etc/ssh

# Set the secure permissions on user home directories
find /home -maxdepth 1 -type d -exec chmod 0700 {} \;

# Restrict access to system logs
chmod 0600 /var/log/*.log

# Set the secure permissions on system executables
chmod 0755 /bin /sbin /usr/bin /usr/sbin /lib /lib64 /usr/lib /usr/lib64

# Disable the use of USB storage devices
echo "install usb-storage /bin/true" > /etc/modprobe.d/disable-usb-storage.conf

echo "Security hardening completed."
