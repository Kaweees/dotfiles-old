# Miguel's Dotfiles

![Screenshot of my desktop]()

As I delicately weave the intricate threads of my dotfiles, I imbue my computing soul into a machine to empty shell of silicon, and my machine is given life. Each line of code, every configuration, and all my preferences, are woven together to create a tapestry that brings my machine to life in a way that is uniquely my own.

These dots contain my most treasured preferences, settings, and configurations, and they are a reflection of how I think and organize my code and projects as a developer. It would be silly to think my dots provide a one size fits all solution for everyone, but I hope that you may find something useful that you could take inspiration from to improve your own dots.

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
