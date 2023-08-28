#!/usr/bin/env bash
    
# Directories where code is located
code_dirs="~/work ~/personal ~/projects"

if [[ $# -eq 1 ]]; then
    # If an argument is given, use it as the session name and directory  
    selected=$1
else
    # If no argument is given, find a directory to use as the session name and directory 
    selected=$(find $code_dirs -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    # If no directory is selected, exit
    exit 0
fi

# Extract the base name of the directory and make it a valid session name
selected_name=$(basename "$selected" | tr . _)
# Check if tmux is running
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # If tmux is not running, start a new session
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    # Create anew tmux session if a session with the same name doesn't exist
    tmux new-session -ds $selected_name -c $selected
fi

# Attach to the session
tmux switch-client -t $selected_name
