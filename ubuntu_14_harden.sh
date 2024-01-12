#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Update the firewall rules

# Flush existing rules
iptables -F

# Set the default policies to DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow incoming SSH (replace 22 with your SSH port if it's different)
#iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow incoming HTTP (replace 80 with your HTTP port if it's different)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow incoming HTTPS (replace 443 with your HTTPS port if it's different)
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow established connections and related traffic
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Deny all other incoming traffic
iptables -A INPUT -j DROP

# Display updated rules
echo "Updated firewall rules:"
iptables -L -n

# Save the rules to persist after reboot (this may vary depending on your distribution)
# For Ubuntu/Debian
service iptables-persistent save
service iptables-persistent restart

# For CentOS/RHEL
service iptables save
service iptables restart

echo "Firewall updated and saved. Ports 80 and 443 are allowed."

