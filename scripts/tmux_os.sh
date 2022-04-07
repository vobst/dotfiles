#!/usr/bin/env bash	
if [[ $(uname | head -c 3) = 'Dar' ]]; then 
  	echo "Dar" > /tmp/hax;
	tmux source-file "${HOME}/dotfiles/tmux_mac.conf";
else
	echo "Linux" > /tmp/hax;
  	tmux source-file "${HOME}/dotfiles/tmux_linux.conf";
fi
