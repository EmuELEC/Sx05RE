#!/bin/sh

    touch /var/lock/start.games
    systemctl start emustation
    rm /var/lock/start.kodi
    systemctl stop kodi


