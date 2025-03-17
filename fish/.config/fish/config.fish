if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/aliases.fish
    if not set -q TMUX
      tmux attach-session -t main || tmux new-session -s main
    end
end

set -Ux TERM xterm-256color
# [ -n "$TMUX" ] && export TERM=screen-256color

zoxide init fish | source
fzf --fish | source
