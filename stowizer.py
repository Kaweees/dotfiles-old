#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["tyro"]
# ///

from __future__ import annotations

import os, subprocess
from typing import List, Dict, Literal
from sys import exit

import tyro
from tyro.conf import Positional

# Exit codes
EXIT_SUCCESS: int = 0
EXIT_FAILURE: int = -1

# Get locations of the home directory and the dotfiles directory
HOME_DIR: str = os.path.expanduser("~")
DOTFILES_DIR: str = os.getenv("DOTFILES") or os.path.dirname(os.path.realpath(__file__))

DOTFILES: Dict[str, Dict[str, str]] = {
    "alacritty": {
        "source": f"{DOTFILES_DIR}/.config/alacritty/",
        "target": f"{HOME_DIR}/.config/alacritty/",
    },
    "herdr": {
        "source": f"{DOTFILES_DIR}/.config/herdr/",
        "target": f"{HOME_DIR}/.config/herdr/",
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

Action = Literal["add", "remove", "view"]
Program = Literal[tuple(DOTFILES)]


def stowizer(action: Positional[Action], program: Positional[Program]):
    """Manage the symlinks of dotfiles using GNU Stow

    Args:
        action: The action to be performed
        program: The program's dotfiles to be processed
    """
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
    exit(EXIT_SUCCESS)


if __name__ == "__main__":
    tyro.cli(stowizer)
