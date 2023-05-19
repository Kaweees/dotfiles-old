# Miscellaneous Developer Environment Setup Notes

This document describes how I set up aspects of my developer environment that are not covered by my [dotfiles](https://github.com/Kaweees/dotfiles) or my [Ansible Playbook](https://github.com/Kaweees/ansible). I have decided to include the following sections because I have found that these are difficult to automate, these should be done manually, and/or I've included as a reference for myself. You may find that you do not need all of them for your projects, although I recommend having them set up as they always come in handy.

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

### Setting up SSH Key-Based Authentication

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
    ```
After completing the steps above, you should be able to connect to the server without entering your password.

### Setting up SSH Key-Based Authentication

Since SSH key-based authentication is more convenient and more secure than password-based authentication, we will configure the server to only use SSH key-based authentication.

To do this, we will edit the server's SSH configuration file. This file is located at `/etc/ssh/sshd_config`.

