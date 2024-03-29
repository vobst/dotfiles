#----
# Keybindings
#----
# vim keybindings
bindkey -v

#----
# PATH
#----
export PATH="${HOME}/.local/bin:${PATH}"


#----
# ENVIRONMENT
#----
export EDITOR=vim

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
alias wr="curl wttr.in" # weather forecast
alias serve='python -m http.server 7331 --directory $(pwd) 2&>1 > /tmp/serve.log &'
alias lsblk="lsblk -o +FSTYPE,FSAVAIL,TYPE,UUID"

#----
# Prompt
#----
# Command Prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %(!.%F{red}%m.%F{blue}%m)%f %B%F{240}%1~%f%b %# '

#----
# Aliases
#----
# git
alias g="git"
# get top processes eating memory
# get top process eating cpu
if [[ $(uname | head -c 3) = 'Dar' ]]; then
  alias psmem="ps auxcm | head -6 | awk '{ printf \"%-24.24s %-18s%-6s\x1b[31m%-6s\x1b[0m\n\", \$11, \$1, \$2, \$4 }'"
  alias pscpu="ps auxcr | head -6 | awk '{ printf \"%-24.24s %-18s%-6s\x1b[31m%-6s\x1b[0m\n\", \$11, \$1, \$2, \$3 }'"
else
  echo "TODO: Adapt for Linux" > /dev/null
fi
# list files
alias l="exa"
alias ll="exa -lbh@F --git"
alias la="ll -a"
# disk usage
alias du="dust"

#----
# Files
#----
# Functions
if [[ -e ${HOME}/.zsh_functions ]] then {
  source ${HOME}/.zsh_functions;
} fi

if [[ -e ${HOME}/.zsh_functions_local ]] then {
  source ${HOME}/.zsh_functions_local;
} fi

if [[ -f ${HOME}/.zsh_local.d/zshrc_local ]] then {
  source ${HOME}/.zsh_local.d/zshrc_local;
} fi
