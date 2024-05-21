<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<div align="left">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]

</div>

<a href="https://github.com/Kaweees/dotfiles">
  <img alt="Neovim Logo" src="assets/img/tux-pixel.png" align="right" width="150" style="border-radius:50%">
</a>

<div align="left">
  <h1><em><a href="https://miguelvf.dev/blog/dotfiles/compendium">~/.dotfiles</a></em></h1>
</div>

<!-- ABOUT THE PROJECT -->

This is my personal collection of configuration files. The [setup section](#installation) will guide you through the installation process.

### Thanks for dropping by!

<img src="assets/img/screenshot.png" alt="Screenshot of my desktop" align="right" width="400px">

Here are some details about my setup:

+ **Operating System**: [Debian 12 ("bookworm")](https://www.debian.org/releases/bookworm/)
+ **Display server**: [Xorg](https://www.x.org/wiki/)
+ **Window Manager**: [dwm](https://tools.suckless.org/dwm/)
+ **Status Bar**: [dmenu](https://tools.suckless.org/dmenu/)
+ **Launcher**: [rofi](https://davatorium.github.io/rofi/)
+ **Terminal**: [st](https://st.suckless.org/)
+ **File Manager**: [Thunar](https://git.xfce.org/xfce/thunar/)
+ **Shell**: [zsh](https://www.zsh.org/)
+ **Editor**: [Neovim](https://neovim.io/)
+ **Browser**: [Vivaldi](https://vivaldi.com)
+ **Color Scheme**: [gruvbox](https://github.com/morhetz/gruvbox)

## Installation

### Using Git and the setup script

You can clone the repository wherever you want. (I like to keep it in `~/Documents/GitHub/dotfiles`, with `~/dotfiles` as a symlink.) The setup script will pull in the latest version and copy the files to your home folder.

```sh
sudo apt update -y
sudo apt install git -y
git clone https://github.com/Kaweees/dotfiles.git ~/Documents/GitHub/Projects/dotfiles --recurse-submodules && cd dotfiles && python3 stowizer.py add zsh
```

```
git submodule update --init --recursive --remote
```


<!-- PROJECT FILE STRUCTURE -->
## Project Structure

```
. dotfiles/
├── .config -> ~/.config           - configuration files for various services
├── .local -> ~/.local             - local data files for various services
├── .scripts -> ~/.scripts         - scripts available to the user at runtime
└── README.md                      - you are here
```

## License

The source code for my website is distributed under the terms of the GNU General Public License v3.0, as I firmly believe that collaborating on free and open-source software fosters innovations that mutually and equitably beneficial to both collaborators and users alike. See [`LICENSE`](./LICENSE) for details and more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Kaweees/dotfiles.svg?style=for-the-badge
[contributors-url]: https://github.com/Kaweees/dotfiles/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Kaweees/dotfiles.svg?style=for-the-badge
[forks-url]: https://github.com/Kaweees/dotfiles/network/members
[stars-shield]: https://img.shields.io/github/stars/Kaweees/dotfiles.svg?style=for-the-badge
[stars-url]: https://github.com/Kaweees/dotfiles/stargazers
