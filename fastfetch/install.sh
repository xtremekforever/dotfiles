#!/bin/bash

CONFIG_DIR=${CONFIG_DIR:=~/.config/fastfetch}

LOGO_FILE=$CONFIG_DIR/logo.txt
CONFIG_FILE=$CONFIG_DIR/config.jsonc

CONFIG=$1
if [ -z $CONFIG ]; then
    CONFIG="swift-logo-american-fastfetch.jsonc"
    echo "No config selected, defaulting to $CONFIG..."
fi

LOGO=$2
if [ -z $LOGO ]; then
    LOGO="swift-logo-american-ascii.txt"
    echo "No logo selected, defaulting to $LOGO..."
fi

echo "Removing old fastfetch configuration..."
rm -f $LOGO_FILE
rm -f $CONFIG_FILE

echo "Linking logo $LOGO for fastfetch to $LOGO_FILE..."
ln -s $(pwd)/$LOGO $LOGO_FILE

echo "Linking config $CONFIG for fastfetch to $CONFIG_FILE..."
ln -s $(pwd)/$CONFIG $CONFIG_FILE
