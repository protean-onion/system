#!/bin/bash

# Find all possible i3 sockets
SOCKETS=$(find /run/user -name "ipc-socket.*" 2>/dev/null)

# Try each socket until one works
for SOCK in $SOCKETS; do
  export I3SOCK=$SOCK
  if i3-msg "focus left" &>/dev/null; then
    echo "Working i3 socket found..."
    ln -sf $SOCK /tmp/i3-ipc.sock
    chmod 755 /tmp/i3-ipc.sock
    break
  fi
done
