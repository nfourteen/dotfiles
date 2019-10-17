#
# Defines personal aliases.
#
# Authors:
#   David Nimorwicz
#

#
# Aliases
#

# Tmux
alias tls="tmux list-sessions"
alias ta="tmux attach-session"
alias tk="tmux kill-session -t"

# Directory
function mkcd () { mkdir -p "$@" && cd "$@"; }
function codestat () { find . -type f -not -path "./.git/*" | xargs wc; }

# Navigation and Listing
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias fhere="find . -name"

# System
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Git
alias glol="git log --graph --decorate --pretty=oneline --abbrev-commit --all"

# Alias vim to nvim if nvim has been installed
if type nvim > /dev/null 2>&1; then
    alias vim=nvim
fi

# Terminal
alias c="clear"
