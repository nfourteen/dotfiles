#
# Provides personal aliases and functions.
#
# Authors:
#   David Nimorwicz
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

# Source module files.
source "${0:h}/alias.zsh"
