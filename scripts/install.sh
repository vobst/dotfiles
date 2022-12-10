#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

#
# tree
#
PREFIX=${HOME}/dotfiles

#
# Command definitions
#

LN="ln -siv"
MKDIR="mkdir -vp"

#
# Function definitions
#

function symlink {
  # $1: target (relative to tree)
  # $2: location (relative to HOME)

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
CONFIGDIRS="i3 i3status broot chromium"
for configdir in $CONFIGDIRS
do
  $MKDIR ${HOME}/.config/${configdir}
  for file in $(find ${PREFIX}/config/${configdir} -maxdepth 1 -type f)
  do
    name=$(basename $file)
    symlink "config/${configdir}/${name}" ".config/${configdir}/${name}"
  done
  touch ${HOME}/.config/$configdir/config_local
done

#
# Local programs and scripts
#
$MKDIR ${HOME}/.local/{opt,bin}
LOCALDIRS="latexindent"
for localdir in $LOCALDIRS
do
  $MKDIR ${HOME}/.local/opt/${localdir}
  for file in $(find ${PREFIX}/local/opt/${localdir} -maxdepth 1 -type f)
  do
    name=$(basename $file)
    symlink "local/opt/${localdir}/${name}" ".local/opt/${localdir}/${name}"
    if [[ -x $file ]]
    then
      symlink "local/opt/${localdir}/${name}" ".local/bin/${name}"
    fi
  done
done

#
# SSH
#
$MKDIR ${HOME}/.ssh/
touch ${HOME}/.ssh/config_local
symlink "config/ssh/config" ".ssh/config"
cat ${HOME}/dotfiles/config/ssh/authorized_keys | \
tee -a ${HOME}/.ssh/authorized_keys > /dev/null

#
# vim
#
$MKDIR ${HOME}/.vim/ftplugin
FTPLUGIN="tex"
for ft in $FTPLUGIN
do
  symlink "config/vim/ftplugin/${ft}.vim" ".vim/ftplugin/${ft}.vim"
done
