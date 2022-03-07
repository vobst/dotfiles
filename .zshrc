#----
# History
#----
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# ctrl+r history search
bindkey '^R' history-incremental-search-backward 

#----
# Misc Configuration
#----
setopt beep notify
# It happens to the best ;)
alias mv='mv --backup=numbered' # (some) protection against deleting by moving

#----
# Keybindings
#----
# vim keybindings
bindkey -v 

#----
# Prompt
#----
# Command Prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %m %B%F{240}%1~%f%b %# '

if [[ -f .zsh_functions ]] then {
  source .zsh_functions;
} fi
