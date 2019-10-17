#!/bin/bash


read -r -p "This is meant to be executed on a new machine. Are you sure? [y|N] " response

if [[ $response =~ (yes|y|Y) ]];then

    echo "Setting up the machine"
    echo ""

    if [ "$(uname)" == "Darwin" ]; then
        echo "Running on OSX"

        echo "Installing Homebrew and useful binaries..."
        source bootstrap/homebrew.sh

        echo "Updating default OSX settings..."
        source bootstrap/mac_defaults.sh
    fi

fi

