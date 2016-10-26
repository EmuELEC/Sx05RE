#!/bin/sh

case $1 in
    post)
        systemctl start connman
    ;;
esac
