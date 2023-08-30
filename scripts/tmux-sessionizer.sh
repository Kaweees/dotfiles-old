#!/bin/sh

picker=${TM_PICKER:-"fzf"}
template_dir=${TM_TEMPLATES_DIR:-"${XDG_CONFIG_HOME:-$HOME/.config}/tmux-companion"}

: "${TM_TEMPLATES:=true}"

die() { printf '%s: %s.\n' "$0" "$1" exit 1 >&2; }
# Searches for all non hidden directories
scrs() {
    tmux list-sessions 2>/dev/null
    [ -n "$TM_SRCS" ] && find $TM_SRCS -maxdepth 1 -type d
}

help() {
    less <<EOF
NAME
    tm - tmux companion

SYNOPSIS
    usage: tm [OPTIONS] [DIRECTORY|NAME]

OPTIONS
    -h, --help
        display help

    -t, --template
        create or edit a template file for a specified directory or arbitrary
        name or, if no arguments are given, the current working directory will
        be used

ENVIROMENT
    The script is configured and customized through enviroment variables.

    TM_SRCS: space separetad list of directories where tm's will let you choose
    when called with no arguments (default:"")

    TM_PICKER: fuzzy finder/picker for selecting directories from from your
    TM_SRCS (default:"fzf")

    TM_TEMPLATES: disable templates capabilities

    TM_TEMPLATES_DIR: where tm searches for directory templates (default:"\$XDG_CONFIG_HOME/tmux-companion/")
EOF
}

template_get() { printf "%s/%s.template\n" "$template_dir" "$1"; }

template_gen() {
    basename=$(basename "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_' | cut -d'.' -f1)
    cat <<EOF >"$1"
#!/bin/sh
# Welcome to the default preset for tmux-companion. As you can see this is a
# POSIX shellscript but you can use whatever POSIX compatible shell language
# you'd like.

###############################################################################
# BE CAREFULL THIS CAN DESTROY YOUR SYSTEM IF YOU DON'T KNOW WHAT YOU ARE DOING
###############################################################################

# This is here to prevent re-executon when switching between sessions
if [ -z "\$TM_LOCK_$basename" ] && [ -n "\$TMUX" ]; then
    export TM_LOCK_$basename=1
elif [ -n "\$TM_LOCK_$basename ]; then
    return
fi

# You can run whatever tmux command you want:
# tmux new-window -d top
# tmux spilt-window python3
# tmux spilt-window ipython
EOF
}

template_run() {
    target=$(template_get "$2")
    "$TM_TEMPLATES" && [ -r "$target" ] && tmux send-keys -t "$1" ". $target" Enter
}

template_edit() {
    target=$(template_get "${1:-$(basename "$PWD")}")
    if [ -d "$template_dir" ]; then
        ! [ -f "$target" ] &&
            template_gen "$target"
        ${EDITOR:-vi} "$target"
    else
        die "$template_dir directory doesn't exitst"
    fi
}

# Getting first 8 caracters of name for preventing tmux to truncate the
# name label box.
# If you have the directory name "tmux-companion" tmux will truncate at the
# 9th line like so: '[tmux-comp'. If instead we take the first 8 characters
# will become something like this: '[tmux-com]'
session_name_fmt() { basename "$1" | sed "s/\./_/g; s/\ /-/g" | head -c8; }

main() {
    case "$1" in
    "")
        sel=$(scrs | "$picker")
        ;;
    -h | --help)
        help
        exit 0
        ;;
    -t | --template)
        template_edit "$2"
        ;;
    .)
        sel="$PWD"
        ;;
    *)
        sel="$*"
        ;;
    esac

    [ -z "$sel" ] && exit 0

    session_name_bs=$(basename "$sel")
    session_name=$(session_name_fmt "$sel")

    if [ -n "$TMUX" ]; then # If in tmux
        tmux has-session -t "$session_name" 2>/dev/null ||
            tmux new-session -ds "$session_name" -c "$sel"
        tmux switch-client -t "$session_name"
    elif [ -z "$TMUX" ]; then # If outside of tmux
        tmux has-session -t "$session_name" 2>/dev/null ||
            tmux new-session -s "$session_name" -c "$sel"
        tmux attach -t "$session_name"
    fi
    template_run "$session_name_bs" "$sel"
}

main "$@"