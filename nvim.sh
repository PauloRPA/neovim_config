#!/bin/bash

CONFIG_HOME="$(pwd)/.." 
NVIM_HOME="$(pwd)/../nvim" 
DATA_HOME=/tmp/local/share # ~/.local/share
STATE_HOME=/tmp/local/state # ~/.local/state

if [[ "$2" == "-t" ]]; then
    DATA_HOME="$XDG_DATA_HOME"
    STATE_HOME="$XDG_STATE_HOME"
fi

if [[ "$1" == "-r" ]]; then
    rm -rf "$DATA_HOME"
    rm -rf "$STATE_HOME"
    rm -rf "$NVIM_HOME/lazy-lock.json"

    mkdir -p "$DATA_HOME"
    mkdir -p "$STATE_HOME"

fi

XDG_DATA_HOME="$DATA_HOME" XDG_STATE_HOME="$STATE_HOME" XDG_CONFIG_HOME="$CONFIG_HOME" nvim -u $CONFIG_HOME/nvim/init.lua $CONFIG_HOME/nvim/init.lua
