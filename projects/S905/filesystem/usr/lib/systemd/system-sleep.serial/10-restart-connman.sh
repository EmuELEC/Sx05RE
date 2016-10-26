#!/bin/sh

case $1 in
    pre)
        systemctl stop connman
    ;;
    post)
        systemctl start connman
    ;;
esac
