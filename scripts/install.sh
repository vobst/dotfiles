#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

#
# Command definitions
#

LN="ln -siv"
MKDIR="mkdir -vp"

#
# Function definitions
#

function symlink {
  # $1: target
  # $2: location

  TARGET=${HOME}/dotfiles/"$1"
  LOCATION=${HOME}/"$2"

  echo "${FUNCNAME[0]}: at $LOCATION to $TARGET"
  $LN $TARGET $LOCATION
}

#
# Dotfiles: symlinks and local files
#
DOTFILES="gdbinit gitconfig gitignore_global zshrc zsh_functions"
DOTFILES=${DOTFILES}" vimrc tmux.conf xinitrc"
for dotfile in $DOTFILES
do
  symlink "$dotfile" ".$dotfile"
  touch "${HOME}/.${dotfile}_local"
done

$MKDIR ${HOME}/.zsh_local.d/
touch ${HOME}/.zsh_local.d/zshrc_local
$MKDIR ${HOME}/.zsh_local.d/extensions

#
# Config files: symlinks and local files
#
CONFIGDIRS="i3 i3status"
for configdir in $CONFIGDIRS
do
  $MKDIR ${HOME}/.config/$configdir
  symlink "config/$configdir/config" ".config/$configdir/config"
  touch ${HOME}/.config/$configdir/config_local
done

#
# SSH
#
mkdir -vp ${HOME}/.ssh/
touch ${HOME}/.ssh/config_local
symlink "config/ssh/config" ".ssh/config"
cat ${HOME}/dotfiles/config/ssh/authorized_keys | \
tee -a ${HOME}/.ssh/authorized_keys > /dev/null
