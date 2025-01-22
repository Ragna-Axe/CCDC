#!/bin/bash

# Define colors for output
GREEN="\033[1;32m"
RED="\033[1;31m"
RESET="\033[0m"

# Check if the user is running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[ERROR] Please run this script as root.${RESET}"
  exit 1
fi

# Define the LinPEAS download URL
LINPEAS_URL="https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh"

# Directory to store LinPEAS
TOOLS_DIR="/opt/linpeas"
LINPEAS_PATH="$TOOLS_DIR/linpeas.sh"

# Create the tools directory if it doesn't exist
if [ ! -d "$TOOLS_DIR" ]; then
  echo -e "${GREEN}[INFO] Creating directory: $TOOLS_DIR${RESET}"
  mkdir -p "$TOOLS_DIR"
fi

# Download LinPEAS
echo -e "${GREEN}[INFO] Downloading LinPEAS...${RESET}"
curl -L -o "$LINPEAS_PATH" "$LINPEAS_URL"

# Check if the download succeeded
if [ ! -f "$LINPEAS_PATH" ]; then
  echo -e "${RED}[ERROR] Failed to download LinPEAS.${RESET}"
  exit 1
fi

# Make the LinPEAS script executable
echo -e "${GREEN}[INFO] Making LinPEAS executable...${RESET}"
chmod +x "$LINPEAS_PATH"

# Run LinPEAS
echo -e "${GREEN}[INFO] Running LinPEAS...${RESET}"
"$LINPEAS_PATH"

echo -e "${GREEN}[INFO] LinPEAS execution completed.${RESET}"
