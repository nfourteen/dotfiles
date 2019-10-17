#!/bin/sh

# C-m -- for tmux to send enter key-binding

SESSION_NAME="mage2_notes"

cd ~/Documents/Notes/Magento/Magento2

tmux has-session -t ${SESSION_NAME}

if [ $? != 0 ]; then
    # create session
    tmux new-session -s ${SESSION_NAME} -n 'notes' -d

    # first window (1) -- vim for note taking
    tmux send-keys -t ${SESSION_NAME} 'vim' C-m

    # file-conversion (2)
    tmux new-window -n 'file-conversion' -t ${SESSION_NAME}
    tmux split-window -h -t ${SESSION_NAME}:2

    # ide (3)
    tmux new-window -n 'ide' -t ${SESSION_NAME} -c ~/Sites/mage2_vagrant/data/magento2
    tmux send-keys -t ${SESSION_NAME}:3 'vim' C-m

    # vbox
    tmux new-window -n 'vbox' -t ${SESSION_NAME} -c ~/Sites/mage2_vagrant
fi
tmux attach-session -t ${SESSION_NAME}


