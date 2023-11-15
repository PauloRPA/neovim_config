#!/bin/bash

CONFIG_HOME="$(pwd)/.." 
DATA_HOME="$XDG_DATA_HOME"
STATE_HOME="$XDG_STATE_HOME"

if [[ "$1" -eq "-t" ]]; then
    DATA_HOME=/tmp/local/share # ~/.local/share
    STATE_HOME=/tmp/local/state # ~/.local/state
fi

if [[ "$2" -eq "-r" ]]; then
    rm -rf "$DATA_HOME"
    rm -rf "$STATE_HOME"
fi

if [[ ! -d "$DATA_HOME" ]]; then
    mkdir -p "$DATA_HOME"
fi

if [[ ! -d "$STATE_HOME" ]]; then
    mkdir -p "$STATE_HOME"
fi

XDG_DATA_HOME=$DATA_HOME XDG_STATE_HOME=$STATE_HOME XDG_CONFIG_HOME="$CONFIG_HOME" nvim $CONFIG_HOME/nvim/init.lua
