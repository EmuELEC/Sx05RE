	rm -rf /var/lock/start.retro
	rm -rf /var/lock/start.games
	touch  /var/lock/start.kodi
	systemctl start kodi
	systemctl stop pegasus
