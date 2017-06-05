import os
import xbmc, xbmcgui, xbmcaddon

dialog = xbmcgui.Dialog()
dialog.notification('Retroarch', 'Launching....', xbmcgui.NOTIFICATION_INFO, 5000)

xbmc.executebuiltin('System.Exec("/usr/bin/retroarch.sh")')
