#!/bin/bash
# Wait longer for the window to fully initialize and then reposition windows at startup.
sleep 5
i3-msg '[title="NeoVim"] floating enable, resize set 1670 1000, move position 0 40'
i3-msg '[title="Development"] floating enable, resize set 1670 1000, move position 0 40'
i3-msg '[title="Ground"] floating enable, resize set 1670 1000, move position 0 40'
