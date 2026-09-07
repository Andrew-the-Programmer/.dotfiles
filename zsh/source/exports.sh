#!/bin/bash

HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export PATH="$OMARCHY_PATH/bin":$PATH
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/projects/git_apps/flutter/bin:$PATH
export GOPATH=$HOME/.local/share/go
export PATH=$PATH:$GOPATH/bin
export CONDA_BIN=/opt/miniconda3/bin
export PATH=$HOME/.local/include:$PATH
export TEXMFHOME=~/texmf
export SUDO_ASKPASS=/usr/local/bin/sudo-askpass
export SHELL=zsh

export ZP_ROOT="$HOME"

export PATH=$PATH:~/.spoof-dpi/bin

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
