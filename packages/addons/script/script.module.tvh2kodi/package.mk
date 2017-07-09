################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="script.module.tvh2kodi"
PKG_VERSION="003c06c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/edit4ever/script.module.tvh2kodi"
PKG_URL="https://github.com/edit4ever/script.module.tvh2kodi/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="xmlstarlet:host"
PKG_SECTION=""
PKG_SHORTDESC="Tvh2Kodi provides access to basic Tvheadend server settings from the Kodi interface."
PKG_LONGDESC="Tvh2Kodi provides access to basic Tvheadend server settings from the Kodi interface."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"

make_target() {
  :
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
  cp $PKG_DIR/changelog.txt $ADDON_BUILD/$PKG_ADDON_ID
}
