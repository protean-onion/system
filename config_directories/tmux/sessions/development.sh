#!/bin/bash

tmux new-session -d -s DEVELOPMENT -c $PROJECT
tmux split-window -t DEVELOPMENT -v -l 17% -c $PROJECT >/home/protean-onion/tmux-sesh.log 2>&1
