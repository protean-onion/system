#!/bin/bash

SESSIONS_DIR=/home/protean-onion/.tmux/sessions

for script in "$SESSIONS_DIR"/*; do
  # Check if the file is executable
  if [ -f "$script" ] && [ -x "$script" ]; then
    "$script" &
  fi
done

# Wait for all background processes to complete
wait
