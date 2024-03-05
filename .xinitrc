#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [[ -f $sysresources ]]; then
  xrdb -merge $sysresources
fi

if [[ -f $sysmodmap ]]; then
  xmodmap $sysmodmap
fi

if [[ -f "$userresources" ]]; then
  xrdb -merge "$userresources"
fi

if [[ -f "$usermodmap" ]]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
feh --bg-fill ~/.config/wallpapers/custom.png
xrandr --output eDP-1 --mode 1920x1200
picom &
exec dwm
