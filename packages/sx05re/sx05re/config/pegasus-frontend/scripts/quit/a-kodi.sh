#!/bin/sh

rm /var/lock/start.pegasus
touch /var/lock/start.kodi
systemctl start kodi
systemctl stop pegasus

