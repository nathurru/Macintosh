#!/bin/bash

if [ -e /usr/local/share ]; then
    chmod 755/usr/local/share
fi

if [ -e /usr/local/share/zsh]; then
    chmod 755 /usr/local/share/zsh
fi

if [ -e /usr/local/share/zsh/site-functions]; then
    chmod 755 /usr/local/share/zsh/site-functions
fi
