if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/aliases.fish
    if not set -q TMUX
      tmux attach-session -t main || tmux new-session -s main
    end
end

set -Ux TERM xterm-256color
# [ -n "$TMUX" ] && export TERM=screen-256color

set -Ux EDITOR /usr/bin/nvim

zoxide init fish | source
fzf --fish | source

function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/luxiopppp/.ghcup/bin $PATH # ghcup-env