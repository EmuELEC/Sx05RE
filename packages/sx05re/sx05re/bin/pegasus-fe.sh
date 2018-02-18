#!/bin/sh

    rm /var/lock/start.kodi
    touch /var/lock/start.pegasus
    systemctl start pegasus
    systemctl stop kodi


