#!/usr/bin/env bash	
if [[ $(hostname | head -c 3) = 'Mac' ]]; then 
  	echo "Mac" > /tmp/hax;
	tmux source-file "${HOME}/dotfiles/tmux_mac.conf";
else
	echo "Linux" > /tmp/hax;
  	tmux source-file "${HOME}/dotfiles/tmux_linux.conf";
fi
