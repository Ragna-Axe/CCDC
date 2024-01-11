#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Remove all users except root
for username in $(awk -F: '$3 >= 1000 && $1 != "root" {print $1}' /etc/passwd); do
  userdel -r $username
  echo "User $username removed."
done

# Change the password for root
echo "Changing the password for root..."
passwd root

echo "Script completed."
