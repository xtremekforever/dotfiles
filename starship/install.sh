#!/bin/bash

CONFIG_FILE=${CONFIG_FILE:=~/.config/starship.toml}

THEME=$1
if [ -z $THEME ]; then
    THEME="starship_powerline_american.toml"
    echo "No theme selected, defaulting to $THEME..."
fi

echo "Removing old Starship theme/configuration..."
rm -f $CONFIG_FILE

echo "Linking new $THEME for Starship to $CONFIG_FILE..."
ln -s $(pwd)/$THEME $CONFIG_FILE
