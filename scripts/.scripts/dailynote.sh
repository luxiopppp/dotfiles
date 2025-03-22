#!/usr/bin/env bash

current_year=$(date +"%Y")
current_month=$(date +"%m")
current_day=$(date +"%d")

vault_dir=~/workspace/vault
main_note_dir=${vault_dir}/daily
note_name=${current_year}-${current_month}-${current_day}
full_path=${main_note_dir}/${note_name}.md

tmux_session_name=${note_name}

if [ ! -d "$main_note_dir" ]; then
  mkdir -p "$main_note_dir"
fi

if [ ! -f "$full_path" ]; then
  touch "$full_path"
fi


if ! tmux has-session -t="$tmux_session_name" 2>/dev/null; then
  tmux new-session -d -s "$tmux_session_name" -c "$main_note_dir" -- nvim "$full_path"
fi

if ! tmux list-panes -t "$tmux_session_name" -F "#{pane_current_command}" | grep -q "nvim"; then
  tmux send-keys -t "$tmux_session_name" "${EDITOR:-nvim}" C-m
fi

tmux switch-client -t "$tmux_session_name"
