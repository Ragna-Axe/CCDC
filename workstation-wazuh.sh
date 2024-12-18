#Agent install 

wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.2-1_amd64.deb && sudo WAZUH_MANAGER='172.20.242.10' WAZUH_AGENT_NAME='Workstation' dpkg -i ./wazuh-agent_4.7.2-1_amd64.deb

#!/bin/bash

# Reload systemd
sudo systemctl daemon-reload

# Enable Wazuh agent service
sudo systemctl enable wazuh-agent

# Start Wazuh agent service
sudo systemctl start wazuh-agent

echo "Systemd commands executed successfully!"
