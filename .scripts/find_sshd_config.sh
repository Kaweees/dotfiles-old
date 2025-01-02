#!/bin/bash

# Array of common SSH server configuration file paths
declare -a ssh_config_paths=(
  "/etc/ssh/sshd_config"
  "/etc/sshd_config"
  "/etc/ssh/ssh_config"
)

# Check each path for the existence of the sshd_config file
for path in "${ssh_config_paths[@]}"; do
  if [[ -f "$path" ]]; then
    echo "SSH server configuration file found at $path"
    exit 0
  fi
done

# If no file is found, display an error message
echo "SSH server configuration file not found"
exit 1