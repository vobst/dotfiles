#----
# Keybindings
#----
# vim keybindings
bindkey -v 

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
alias mv='mv -i' # (some) protection against deleting by moving


#----
# Prompt
#----
# Command Prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %m %B%F{240}%1~%f%b %# '

#----
# Aliases
#----
# git
alias g="git"
alias gs="git status"
alias gu="git add -u"
alias gc="git commit -m"
# get top processes eating memory
# get top process eating cpu
if [[ $(hostname | head -c 3) = 'Mac' ]]; then
  alias psmem="ps auxcm | head -6 | awk '{ printf \"%-24.24s %-18s%-6s\x1b[31m%-6s\x1b[0m\n\", \$11, \$1, \$2, \$4 }'"
  alias pscpu="ps auxcr | head -6 | awk '{ printf \"%-24.24s %-18s%-6s\x1b[31m%-6s\x1b[0m\n\", \$11, \$1, \$2, \$3 }'"
else
  echo "TODO: Adapt for Linux" > /dev/null
fi

#----
# Files
#----
# Functions
if [[ -f .zsh_functions ]] then {
  source .zsh_functions;
} fi

if [[ -f .zsh_local ]] then {
  source .zsh_local;
} fi
