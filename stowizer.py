import argparse, os, subprocess
from typing import List, Dict
from sys import exit

# Exit codes
EXIT_SUCCESS: int = 0
EXIT_FAILURE: int = -1

# Get locations of the home directory and the dotfiles directory
HOME_DIR: str = os.getenv("HOME")
DOTFILES_DIR: str = os.getenv("DOTFILES")
if DOTFILES_DIR is None:
    DOTFILES_DIR = os.path.dirname(os.path.realpath(__file__))

DOTFILES: Dict[str, Dict[str, str] | List[str]] = {
    "alacritty": {
        "source": f"{DOTFILES_DIR}/.config/alacritty/",
        "target": f"{HOME_DIR}/.config/alacritty/",
    },
    "htop": {
        "source": f"{DOTFILES_DIR}/.config/htop/",
        "target": f"{HOME_DIR}/.config/htop/",
    },
    "nvim": {
        "source": f"{DOTFILES_DIR}/.config/nvim/",
        "target": f"{HOME_DIR}/.config/nvim/",
    },
    "picom": {
        "source": f"{DOTFILES_DIR}/.config/picom/",
        "target": f"{HOME_DIR}/.config/picom/",
    },
    "tmux": {
        "source": f"{DOTFILES_DIR}/.config/tmux/",
        "target": f"{HOME_DIR}/.config/tmux/",
    },
    "xorg": {"source": f"{DOTFILES_DIR}/.config/xorg/", "target": f"{HOME_DIR}/"},
    "zsh": {"source": f"{DOTFILES_DIR}/.config/zsh/", "target": f"{HOME_DIR}/"},
    "fonts": {
        "source": f"{DOTFILES_DIR}/.fonts/",
        "target": f"/usr/local/share/fonts/",
    },
    "wallpapers": {
        "source": f"{DOTFILES_DIR}/.wallpapers/",
        "target": f"{HOME_DIR}/.config/wallpapers/",
    },
    "scripts": {
        "source": f"{DOTFILES_DIR}/.scripts/",
        "target": f"{HOME_DIR}/.scripts/",
    },
    "dunst": {
        "source": f"{DOTFILES_DIR}/.config/dunst/",
        "target": f"{HOME_DIR}/.config/dunst/",
    },
    "rofi": {
        "source": f"{DOTFILES_DIR}/.config/rofi/",
        "target": f"{HOME_DIR}/.config/rofi/",
    },
    "git": {"source": f"{DOTFILES_DIR}/.config/git", "target": f"{HOME_DIR}/"},
    "aerospace": {
        "source": f"{DOTFILES_DIR}/.config/aerospace",
        "target": f"{HOME_DIR}/",
    },
    "yabai": {"source": f"{DOTFILES_DIR}/.config/yabai", "target": f"{HOME_DIR}/"},
}

# DOTFILES["all"] = choices=DOTFILES.keys()


def stowizer(action: str, program: str):
    source_dir = DOTFILES[program]["source"]
    target_dir = DOTFILES[program]["target"]

    if action == "add" or action == "remove":
        # Check if destination directory exists, if not create it
        if not os.path.exists(target_dir):
            os.makedirs(target_dir)

        # Construct the command
        command = [
            "stow",
            "--restow" if action == "add" else "--delete",
            f"--dir={source_dir}",
            f"--target={target_dir}",
            ".",
        ]
        print(f"Command: {' '.join(command)}")

        # Execute the command
        try:
            result = subprocess.run(command, check=True, text=True, capture_output=True)
            print(result.stdout)
        except subprocess.CalledProcessError as e:
            print(f"Error executing command: {e.stderr}")
            exit(EXIT_FAILURE)
        pass

    elif action == "view":
        print(f"Source: {source_dir}")
        print(f"Target: {target_dir}")
    else:
        print(f"Error: Invalid action '{action}'")
        exit(EXIT_FAILURE)
    exit(EXIT_SUCCESS)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Manage the symlinks of dotfiles using GNU Stow"
    )
    parser.add_argument(
        "action", help="The action to be performed", choices=["add", "remove", "view"]
    )
    parser.add_argument(
        "program",
        help="The program's dotfiles to be processed",
        choices=DOTFILES.keys(),
    )
    args = parser.parse_args()

    # Check if the number of arguments is correct
    if len(args.__dict__) != 2:
        parser.print_usage()
        exit(EXIT_FAILURE)

    # Call stowizer function with the parsed argument
    stowizer(args.action, args.program)
