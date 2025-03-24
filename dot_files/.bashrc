# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# degbug mode
# export PS4='+(${BASH_SOURCE[0]}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
# set -x
# alias table="source ~/.bashrc $> log"

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# https://github.com/mikesmithgh/git-prompt-string
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)} $(git-prompt-string --prompt-prefix "" --prompt-suffix "")\[\033[38;2;253;0;17m\] >\[\033[00m\] '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Customisations
### tex https://tug.org/texlive/quickinstall.html

### authentication
# export $(grep -v '^#' /home/protean-onion/.system/dot_files/.authenticate | xargs)

### activate python virtual environment
### write a rofi script for switching between virtual environments

# custom scripts in path
# create symbolic links of files within every relevant directory in the current directory
alias pool="/home/protean-onion/Projects/code/ars-wilding/utils/system-management/pool/pool.sh"
export POOL_PATHS="/home/protean-onion/Projects/code/ars-wilding/utils"
export POOL_DIR="/home/protean-onion/Projects/code/ars-wilding/utils/system-management/pool/pooled-scripts/"
export POOL_TMP="/home/protean-onion/Projects/code/ars-wilding/utils/system-management/pool/pooled-scripts/tmp"
### make personal scripts universally available
export PATH="$PATH:$POOL_DIR:$POOL_TMP"
export PATH=$PATH:$(find /home/protean-onion/.system/scripts/ -type d | tr '\n' ':' | sed 's/:$//')

# export directory variables and make command aliases for ease of access
export CODE="/home/protean-onion/Projects/code"
export ARS_WILDING="$CODE/ars-wilding"
export ANIMA_MUNDI="$CODE/anima-mundi"
export STUDY="$CODE/study"
export REPOS="/home/protean-onion/Projects/code/gh-repos"
export PROJECT="/home/protean-onion/Projects/code/study/therustprogramminglanguage"

alias ars-wilding="cd $ARS_WILDING && pwd"
alias anima-mundi="cd $ANIMA_MUNDI && pwd"
alias study="cd $STUDY && pwd"
alias cd-code="cd $CODE && pwd"
alias repos="cd $REPOS && pwd"
alias project="cd $PROJECT && pwd"

# aliases for virtual environments
alias hermes="source /home/protean-onion/.venvs/hermes/bin/activate"
alias experimental="source /home/protean-onion/.venvs/experimental/bin/activate"

# command macros
alias cat-files='for file_name in $(ls $(pwd)); do echo "File Name: $file_name"; cat $file_name; echo "------------"; done'

# nvidia https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions
export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}

# LaTeX
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/home/protean-onion/Projects/code/installations/go
export PATH=$PATH:$GOPATH/bin

# system76 hybrid graphics https://support.prometheus76.com/articles/graphics-switch-pop/
### `hybrid` mode command to offload on dGPU
alias nvidia_run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
### `nvidia` mode:
### # Only works with `lightdm`. It's important to switch accordingly using `sudo dpkg-reconfigure `some binary for a display manager``
### # But I think it's the Intel iGPU that's generating the screen tear. If you want to watch a movie, use this mode.
alias movies="system76-power graphics nvidia; sudo dpkg-reconfigure lightdm"
### # Revert to standard usage, or `hybrid` mode
alias hybrid="system76-power graphics hybrid; sudo dpkg-reconfigure gdm3"

# Created by `pipx` on 2024-08-28 12:32:16
export PATH="$PATH:/home/protean-onion/.local/bin"

# Fix brightness
### Added a systemctl service to fix this issue. See 'services' in `.system`.
function brightness {
  sudo chmod 777 /sys/devices/pci0000\:00/0000\:00\:02.0/drm/card1/card1-eDP-1/intel_backlight/brightness >/dev/null 2>&1
} || {
  sudo chmod 777 /sys/devices/pci0000\:00/0000\:00\:02.0/drm/card2/card2-eDP-1/intel_backlight/brightness >/dev/null 2>&1
}

# Some weird permissions issue
alias chat="cd /home/protean-onion/Projects/code/community/llms/LibreChat & docker compose up -d"

# Headaches for `manim`
### Links:
###   - https://www.linuxfromscratch.org/blfs/view/git/multimedia/libvdpau.html
###   - https://www.linuxfromscratch.org/blfs/view/svn/x/xorg7.html
### It started working, but I don't know if this is what fixed it. I guess I'll just let this be.
export XORG_PREFIX="/usr"
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

# PS5 Controller Connection Alias
export controller="E8:47:3A:59:D2:47"
export controller2="E8:47:3A:5A:05:FF"

# DeepSeek scripts
export PYTHONPATH="/home/protean-onion/Projects/code/community/ai/models/deepseek/Janus:$PYTHONPATH"

# node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Homebrew
### The things we do for family.
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
. "$HOME/.cargo/env"
alias vpn="nordvpn connect United_Kingdom"

# Miniforge
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/protean-onion/Projects/code/installations/miniforge3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/protean-onion/Projects/code/installations/miniforge3/etc/profile.d/conda.sh" ]; then
    . "/home/protean-onion/Projects/code/installations/miniforge3/etc/profile.d/conda.sh"
  else
    export PATH="/home/protean-onion/Projects/code/installations/miniforge3/bin:$PATH"
  fi
fi
unset __conda_setup

export CONDA_PREFIX="/home/protean-onion/Projects/code/installations/miniforge3"
# <<< conda initialize <

# OBS Virtual Camera
alias vitual-camera="sudo modprobe v4l2loopback"

# Facefusion
alias facefusion="conda activate facefusion ; cd /home/protean-onion/Projects/code/installations/facefusion ; python facefusion.py run --open-browser"

# DeepSeek PDF directory for chat extraction
export DEEPSEEK="/home/protean-onion/Documents/LLM-Conversations/DeepSeek"

# NeoVim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# tmux
# Claude | Function to list tmux sessions and prompt for action
# Function to list tmux sessions and prompt for action
tmux_starter() {
  # Check if we're already in a tmux session
  if [ -n "$TMUX" ]; then
    return
  fi

  # Check if tmux is installed
  if ! command -v tmux &>/dev/null; then
    echo "tmux is not installed"
    return
  fi

  # Get list of running tmux sessions
  sessions=$(tmux list-sessions 2>/dev/null)

  # If there are no sessions
  if [ -z "$sessions" ]; then
    read -p "No tmux sessions found. Create a new one? (y/n): " choice
    case "$choice" in
    y | Y)
      exec tmux new-session
      # exec replaces the current process, so no code after this runs
      ;;
    *)
      echo "No tmux session started"
      ;;
    esac
    return
  fi

  # Display available sessions
  echo "Available tmux sessions:"
  echo "$sessions" | cat -n

  # Prompt user for action
  echo
  echo "Options:"
  echo "  [number] - Attach to session"
  echo "  n        - Create new session"
  echo "  q        - Do nothing"
  echo
  read -p "What would you like to do? " choice

  # Process user choice
  if [[ "$choice" =~ ^[0-9]+$ ]]; then
    # Get the session name from the chosen number
    session_name=$(echo "$sessions" | sed -n "${choice}p" | cut -d: -f1)
    if [ -n "$session_name" ]; then
      exec tmux attach-session -t "$session_name"
      # exec replaces the current process, so no code after this runs
    else
      echo "Invalid session number"
    fi
  elif [[ "$choice" =~ ^[nN]$ ]]; then
    exec tmux new-session
    # exec replaces the current process, so no code after this runs
  else
    echo "No tmux session started"
  fi
}

# Create a lock file to prevent running multiple times
# TMUX_STARTER_RAN="/tmp/tmux_starter_ran_$$"

# Only run the function if:
# 1. We're in an interactive shell
# 2. We haven't already run it in this shell session
# 3. We're not already in a tmux session
# if [[ $- == *i* ]] && [ ! -f "$TMUX_STARTER_RAN" ] && [ -z "$TMUX" ]; then
#     touch "$TMUX_STARTER_RAN"
#     tmux_starter
# The lock file will be removed when the shell exits
# fi

# Add this line to your .bashrc to run the function when a new terminal is opened
# if [[ $- == *i* ]]; then
#     tmux_starter
# fi

alias copy="xclip -selection clipboard"

# pkg-config configuration
# export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:$PKG_CONFIG_PATH"
