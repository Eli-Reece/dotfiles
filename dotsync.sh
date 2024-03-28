#!/bin/bash

# This script is used to sync dotfiles from my home directory in the top level of this dir

# Current directory
DIR="$PWD"

# go into the symbolinks dir
cd symbolinks

# Copy the actual file from the symbolink into the top level
# hypr 
cp -rvL hypr/hyprland.conf    $DIR/hypr/hyprland.conf
cp -rvL hypr/keybindings.conf $DIR/hypr/keybindings.conf
cp -rvL hypr/monitors.conf    $DIR/hypr/monitors.conf
cp -rvL hypr/nvidia.conf      $DIR/hypr/nvidia.conf
cp -rvL hypr/windowrules.conf $DIR/hypr/windowrules.conf
# kitty
cp -rvL kitty/kitty.conf        $DIR/kitty/kitty.conf
cp -rvL kitty/themes/theme.conf $DIR/kitty/themes/theme.conf
# ranger
cp -rvL ranger/rc.conf    $DIR/ranger/rc.conf
cp -rvL ranger/rifle.conf $DIR/ranger/rifle.conf
# bash & zsh
cp -rvL bashzsh/.bashrc $DIR/bashzsh
cp -rvL bashzsh/.zshrc  $DIR/bashzsh
