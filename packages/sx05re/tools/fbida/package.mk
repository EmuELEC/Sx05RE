################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="fbida"
PKG_VERSION="2.13"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_SECTION="tools"
PKG_SHORTDESC="The fbida project contains a few applications for viewing and editing images, with the main focus being photos."
PKG_LONGDESC="The fbida project contains a few applications for viewing and editing images, with the main focus being photos."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : not
}

makeinstall_target() {

  mkdir -p $INSTALL/usr/lib/
    cp -rf $PKG_DIR/lib/* $INSTALL/usr/lib/
   
  mkdir -p $INSTALL/usr/bin/
    cp -rf $PKG_DIR/bin/* $INSTALL/usr/bin/
    chmod +x $INSTALL/usr/bin/fbi
}
