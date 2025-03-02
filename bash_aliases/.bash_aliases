alias ls='eza'
alias ll='eza -l'
alias la='eza -a'

alias cl='clear'
alias cd..='cd ..'

# alias .bash='. ~/.bashrc'
alias .fish='. ~/.config/fish/config.fish'

alias locate="plocate"

alias n="nvim"

# GIT
alias gst='git status'
alias gch='git checkout'
alias gcb='git checkout branch'
alias glog='git log'
alias gcom='git commit -m'
gadd() { 
  git add "${1:-.}"
}
