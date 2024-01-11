#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or using sudo."
  exit 1
fi

# Get a list of all user accounts excluding root
users=$(awk -F: '$3 >= 1000 && $1 != "root" {print $1}' /etc/passwd)

# Iterate through each user and change the password
for user in $users; do
  # Prompt for a new password
  read -p "Enter new password for user $user: " -s password
  echo

  # Change the password
  echo -e "$password\n$password" | passwd "$user"

  # Check if the password change was successful
  if [ $? -eq 0 ]; then
    echo "Password for user $user changed successfully."
  else
    echo "Failed to change password for user $user."
  fi
done

echo "All user passwords (excluding root) have been changed."
