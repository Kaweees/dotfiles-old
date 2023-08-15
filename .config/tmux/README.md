# Tmux

## Usage

Install tmux
```bash
sudo apt install tmux
```

Install tpm (Tmux Plugin Manager)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Reload TMUX environment so TPM is sourced:

```bash
# type this in terminal if tmux is already running
tmux source $XDG_CONFIG_HOME/tmux/tmux.conf
```

## Keybinds

To enter commands into tmux, you must enter a specific keybind, which is called the prefix key, followed by the command. My prefix key is <kbd>ctrl</kbd> + <kbd>space</kbd>.

To refresh tmux and install new plugins, type <kbd>prefix</kbd> + <kbd>I</kbd> (capital i, as in Install)

### Window Management Commands

| Command Keybind | Command Description |
| --------------- | ------------------- |
| <kbd>prefix</kbd> + <kbd>c</kbd> | create new window and switch to it |
| <kbd>prefix</kbd> + <kbd>#</kbd> | switch to window # |
| <kbd>prefix</kbd> + <kbd>n</kbd> | switch to next window |
| <kbd>prefix</kbd> + <kbd>p</kbd> | switch to previous window |
| <kbd>prefix</kbd> + <kbd>:</kbd> | swap window with next window |
| <kbd>prefix</kbd> + <kbd>;</kbd> | swap window with previous window |
| <kbd>prefix</kbd> + <kbd>&</kbd> | kill window and all panes in it |

### Pane Management Commands

| Command Keybind | Command Description |
| --------------- | ------------------- |
| <kbd>prefix</kbd> + <kbd>%</kbd> | split a pane horizontally into two panes |
| <kbd>prefix</kbd> + <kbd>"</kbd> | split a pane vertically into two panes |
| <kbd>prefix</kbd> + <kbd>{</kbd> | swap pane with previous pane |
| <kbd>prefix</kbd> + <kbd>}</kbd> | swap pane with next pane |
| <kbd>prefix</kbd> + <kbd>h</kbd> / <kbd>←</kbd> | switch to pane on the left |
| <kbd>prefix</kbd> + <kbd>j</kbd> / <kbd>↓</kbd> | switch to pane below |
| <kbd>prefix</kbd> + <kbd>k</kbd> / <kbd>↑</kbd> | switch to pane above |
| <kbd>prefix</kbd> + <kbd>l</kbd> / <kbd>→</kbd> | switch to pane on the right |
| <kbd>prefix</kbd> + <kbd>q</kbd> + <kbd>#</kbd> | switch active pane to pane # |
| <kbd>prefix</kbd> + <kbd>z</kbd> | zoom in/out of pane to take up full window |
| <kbd>prefix</kbd> + <kbd>!</kbd> | break pane into a new window |
| <kbd>prefix</kbd> + <kbd>x</kbd> | kill pane |

### Miscellaneous Commands
| Command Keybind | Command Description |
| --------------- | ------------------- |
| <kbd>v</kbd> | start selection in copy mode | 
| <kbd>y</kbd> | yank (copy) selection to system clipboard |
| <kbd>ctrl</kbd> + <kbd>v</kbd> | toggle between rectangular and line selection mode |
| <kbd>prefix</kbd> + <kbd>r</kbd> | refresh tmux configuration |