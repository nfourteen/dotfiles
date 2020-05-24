#!/bin/bash

# new-session -x and -y send current terminal window size so select-layout
# lays them out evenly
# see: https://davidtranscend.com/blog/tmux-script-percentage-issue/

SESSION="Development"

# Check if session already exists, suppressing output
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then

tmux new-session -d -s $SESSION -c /Volumes/Development/swiftotter -x $(tput cols) -y $(tput lines)

tmux split-window -v -c /Volumes/Development/swiftotter
tmux split-window -v -c /Volumes/Development/swiftotter
tmux select-layout main-vertical

tmux select-pane -t 1

fi

tmux attach -t $SESSION
