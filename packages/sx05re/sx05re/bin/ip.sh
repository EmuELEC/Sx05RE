#!/bin/sh
ifconfig
ifconfig > /storage/.config/ipinformation.txt
read -n1 -r -p "Press any key to continue..." key
