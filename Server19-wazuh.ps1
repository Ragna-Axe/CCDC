Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.2-1.msi -OutFile ${env.tmp}\wazuh-agent; msiexec.exe /i ${env.tmp}\wazuh-agent /q WAZUH_MANAGER='172.20.242.10' WAZUH_AGENT_NAME='Server19' WAZUH_REGISTRATION_SERVER='172.20.242.10' 
NET START WazuhSvc
