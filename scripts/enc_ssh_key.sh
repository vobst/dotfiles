#!/usr/bin/env bash
# Save your ssh key's passphrase encrypted with your system password

echo "type your system password"
read -s SYS_PW

echo "type your ssh key's passphrase"
read -s SSH_PW

echo $SSH_PW | openssl enc -pbkdf2 -in - -out ~/.ssh/passphrase -e -aes256 -k "$SYS_PW"

unset PASSWORD
unset PASSPHRASE
