# Enable zsh profiling for debugging
# zmodload zsh/zprof

# Set encoding
export LC_ALL=en_US.UTF-8

# -------------------------------------------------------------------
# Set dotfile paths for easier editing.
# -------------------------------------------------------------------
export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/.config/zsh
export MODULES=$ZSH/modules

# -------------------------------------------------------------------
# Load environment variables
# -------------------------------------------------------------------
source $ZSH/env.zsh

# -------------------------------------------------------------------
# Load custom aliases
# -------------------------------------------------------------------
source $ZSH/aliases.zsh

# -------------------------------------------------------------------
# Load custom functions
# -------------------------------------------------------------------
source $ZSH/functions.zsh

# -------------------------------------------------------------------
# Load custom exports
# -------------------------------------------------------------------
source $ZSH/exports.zsh
