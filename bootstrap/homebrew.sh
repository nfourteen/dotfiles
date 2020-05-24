#!/usr/bin/env bash
set -eu

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# cli tools
brew install ag # required for Vim plugins
brew install ack
brew install tree
brew install htop
brew install wget
brew install vim
brew install nvim
brew install tmux

# development tools
brew install git
brew install zsh
brew install node

