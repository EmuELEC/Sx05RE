#!/bin/sh

rm /var/lock/start.pegasus
rm /var/lock/start.kodi
systemctl stop kodi
systemctl stop pegasus
shutdown -r now


