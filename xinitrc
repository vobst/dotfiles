#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# create pidfile for status bar
#pgrep -u $(id -u) ssh-agent > /run/user/$(id -u)/ssh-agent.pid
pgrep NetworkManager > /tmp/NetworkManager.pid
pgrep pipewire > /tmp/pipewire.pid

# remap capslock to escape
setxkbmap -option caps:escape

# use LSHIFT+RSHIFT to switch between German an US keyboard
setxkbmap -model pc105 -layout us,de -option grp:shifts_toggle,ctrl:nocaps

exec /usr/bin/i3
