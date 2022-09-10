# Miguel's dotfiles

![Screenshot of my shell prompt]()

All my dotfiles in a single place

## Installation

### Using Git and the setup script

You can clone the repository wherever you want. (I like to keep it in `~/Documents/GitHub/dotfiles`, with `~/dotfiles` as a symlink.) The setup script will pull in the latest version and copy the files to your home folder.

```bash
sudo apt update -y
sudo apt install git -y
git clone https://github.com/kaweees/dotfiles.git && cd dotfiles && source setup.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source setup.sh
```

Alternatively, to update while also avoiding the confirmation prompt:

```bash
set -- -f; source setup.sh
```
