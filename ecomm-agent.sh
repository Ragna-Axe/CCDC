#install Wazuh Agent

curl -o wazuh-agent-4.7.2-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.7.2-1.x86_64.rpm && sudo WAZUH_MANAGER='172.20.242.10' WAZUH_AGENT_NAME='Ecomm' rpm -ihv wazuh-agent-4.7.2-1.x86_64.rpm

#!/bin/bash

# Reload systemd
sudo systemctl daemon-reload

# Enable Wazuh agent service
sudo systemctl enable wazuh-agent

# Start Wazuh agent service
sudo systemctl start wazuh-agent

echo "Systemd commands executed successfully!"
