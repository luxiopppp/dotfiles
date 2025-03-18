alias ls='eza'
alias ll='eza -l'
alias la='eza -a'

alias cl='clear'
alias c='clear'
alias cd..='cd ..'
alias z..='z ..'

# alias .bash='. ~/.bashrc'
alias .fish='. ~/.config/fish/config.fish'

alias locate="plocate"

alias n="nvim"

# GIT
alias gst='git status'
alias glog='git log'
alias ga='git add'
alias gaa='git add .'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcm='git commit -m'

alias gch='git checkout'
alias gcb='git checkout -b'

alias gsta='git stash'
alias gsts='git stash show --text'
alias gstp='git stash pop'
alias gstd='git stash drop'

function current_branch
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo ref | sed s-refs/heads--
end

alias ggpull='git pull origin (current_branch)'
alias ggpur='git pull --rebase origin (current_branch)'
alias ggpush='git push origin (current_branch)'
alias ggpnp='git pull origin (current_branch); and git push origin (current_branch)'
