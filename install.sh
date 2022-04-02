#!/usr/bin/env bash
echo "--- Beta installer, hope you did a backup :)"
echo "--- Creating symlinks"
# git
ln -swiv ${HOME}/dotfiles/gitconfig ${HOME}/.gitconfig
ln -swiv ${HOME}/dotfiles/gitignore_global ${HOME}/.gitignore_global
# zsh
ln -swiv ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc
ln -swiv ${HOME}/dotfiles/.zsh_functions ${HOME}/.zsh_functions
# vim
ln -swiv ${HOME}/dotfiles/.vimrc ${HOME}/.vimrc
# tmux
ln -swiv ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf
echo "--- Initializing empty local configs"
# git
touch ${HOME}/.gitconfig_local
# zsh
mkdir ${HOME}/.zsh_local.d/ && touch ${HOME}/.zsh_local.d/zshrc_local && \
mkdir ${HOME}/.zsh_local.d/extensions
# vim
touch ${HOME}/.vimrc_local
echo "--- Done destroying your home"
