import os
import xbmc, xbmcgui, xbmcaddon

dialog = xbmcgui.Dialog()
dialog.notification('Pegasus-fe', 'Launching....', xbmcgui.NOTIFICATION_INFO, 5000)

xbmc.executebuiltin('System.Exec("nohup /usr/bin/pegasus-fe.sh")')
xbmc.executebuiltin('Quit')
