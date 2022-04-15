#!/usr/bin/env bash
echo "--- Beta installer, hope you did a backup :)"
echo "--- Creating symlinks"
# gdb
ln -siv ${HOME}/dotfiles/gdbinit ${HOME}/.gdbinit
# git
ln -siv ${HOME}/dotfiles/gitconfig ${HOME}/.gitconfig
ln -siv ${HOME}/dotfiles/gitignore_global ${HOME}/.gitignore_global
# zsh
ln -siv ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc
ln -siv ${HOME}/dotfiles/.zsh_functions ${HOME}/.zsh_functions
# vim
ln -siv ${HOME}/dotfiles/.vimrc ${HOME}/.vimrc
# tmux
ln -siv ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf
echo "--- Initializing empty local configs"
# git
echo "${HOME}/.gdbinit_local"
touch ${HOME}/.gdbinit_local
# git
echo "${HOME}/.gitconfig_local"
touch ${HOME}/.gitconfig_local
# zsh
echo "${HOME}/.zsh_local.d/zshrc_local"
mkdir ${HOME}/.zsh_local.d/ && touch ${HOME}/.zsh_local.d/zshrc_local && \
mkdir ${HOME}/.zsh_local.d/extensions
# vim
echo "${HOME}/.vimrc_local"
touch ${HOME}/.vimrc_local
echo "--- Setting up remote access"
cat ${HOME}/dotfiles/config/ssh/authorized_keys >> ${HOME}/.ssh/authorized_keys
echo "--- Done destroying your home"
