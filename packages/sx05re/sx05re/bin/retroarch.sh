#!/bin/sh

    touch /var/lock/start.retro
    systemctl start retroarch
    rm /var/lock/start.kodi
    systemctl stop kodi


