# Miscellaneous Developer Environment Setup Notes

This document describes how I set up aspects of my developer environment that are not covered by my [dotfiles](https://github.com/Kaweees/dotfiles) or my [Ansible Playbook](https://github.com/Kaweees/ansible). I have decided to include the following sections because I have found that these are difficult to automate, these should be done manually, and/or I've included as a reference for myself. You may find that you do not need all of them for your projects, although I recommend having them set up as they always come in handy.

## Table of Contents

- [Secure Shell (ssh)](#secure-shell-ssh)
  - [Installation](#installation)
  - [Usage](#usage)
  - [SSH Key-Based Authentication Setup](#ssh-key-based-authentication-setup)
  - [Enabling SSH Key-Based Authentication Only](#enabling-ssh-key-based-authentication-only)
    - [Method 1 - Configuration via ssh-copy-id](#method-1---configuration-via-ssh-copy-id)
    - [Method 2 - Manual Configuration](#method-2---manual-configuration)
- [Git](#git)



## Secure Shell (ssh)

### Installation

ssh is already installed on most Linux distributions. To check whether you have it installed, run the following command:
```sh
ssh -V
```

If ssh is not installed on your machine, you can install it by running the following command:
```sh
sudo apt-get install openssh-client openssh-server
```

### Usage

Once ssh is installed on your machine, you can connect to remote servers and interface with them via the commands line. To connect to the server, use the following command:
```sh
ssh <username>@<server_ip>
exit # to exit the server
```

### SSH Key-Based Authentication Setup

Normally, connecting to a server via ssh requires you to enter your password. This is called password-based authentication. 

However, you can set up SSH key-based authentication so that you do not have to enter your password every time you connect to a server. 

To set up SSH key-based authentication, follow the steps below.

1. Generate a new ssh key (we will generate an RSA SSH key pair with a key size of 4096 bits)
    > Note: Do not change the default name or location of the key. Using a passphrase is optional but not recommended.
    ```sh
    # Generate a new ssh key
    ssh-keygen -t rsa -b 4096
    ```
2. Copy the public key to the server
    ```sh
    # Ssh into the server
    ssh <username>@<server_ip>
    # Create ssh directory
    mkdir ~/.ssh
    cd ~/.ssh
    # exit server
    exit
    ```
    On your local machine execute the following commands:
    ```sh
    scp ~/.ssh/id_rsa.pub <username>@<server_ip>:~/.ssh/authorized_keys
    ```
3. Change the permissions of the ssh directory and its contents to prevent other users from accessing your keys
    ```sh
    # Ssh into the server
    ssh <username>@<server_ip>
    # Restrict read, write, and execute permissions to the `~/.ssh` directory to only the owner (`username`)
    chmod 700 ~/.ssh/
    # Restrict read and write permissions to the contents of the `authorized_keys` directory to only the owner (`username`)
    chmod 600 ~/.ssh/authorized_keys
    # exit server
    exit
    ```
After completing the steps above, you should be able to connect to the server without entering your password.

### Enabling SSH Key-Based Authentication Only

Since SSH key-based authentication is more convenient and more secure than password-based authentication, we will restrict the server to only use SSH key-based authentication.

To do this, we will edit the server's SSH configuration file. This file is located at `/etc/ssh/sshd_config`.

> Note: Password-based authentication and challenge-response authentication will be disabled. If you do not have password-based authentication [already configured](#setting-up-ssh-key-based-authentication), you will not be able to connect to the server.

## Method 1 - Configuration via ssh-copy-id

To configure the server to only use SSH key-based authentication via ssh-copy-id, follow the steps below.

```bash
# Copy the public key to the server
ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<server_ip>
# Ssh into the server
ssh <username>@<server_ip>
# exit server
exit
```

## Method 2 - Manual Configuration

To manually configure the server to only use SSH key-based authentication, follow the steps below. 

> Note: the location of the SSH configuration file is assumed to be located at `/etc/ssh/sshd_config`. If this is not the case, you will need to modify the commands below to reflect the location of the SSH configuration file. You can find the location of the SSH configuration file by executing a script I wrote found in my [dotfiles's](https://github.com/Kaweees/dotfiles) `/scripts` folder 
> ```sh
> # make find_sshd_config executable
> chmod +x find_sshd_config.sh
> ./find_sshd_config.sh

```bash
# Ssh into the server
ssh <username>@<ip>
# /etc/ssh/sshd_config = ssh config of server 
# Disable password-based authentication
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# Disable challenge-response authentication
sudo sed -i 's/^#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
# Enable public key authentication on the server 
sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# Restart the server's SSH service to apply the new configuration
if [[ $(ps -p 1 -o comm=) == "systemd" ]]; then
  ## On systemd-based systems
  echo "System is systemd-based. Restarting sshd."
  sudo systemctl restart sshd
else
  ## On SysV init systems
  echo "System is SysV init-based. Restarting ssh."
  sudo service ssh restart
fi
echo "SSH configuration completed. Disconnecting from server."
# exit server
exit # exit server
```