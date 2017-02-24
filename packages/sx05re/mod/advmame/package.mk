################################################################################
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="advmame"
PKG_VERSION="1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE=""
PKG_URL="" 
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/games/mod"
PKG_SHORTDESC="An arcade emulator"
PKG_LONGDESC="An arcade emulator"
 

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  mkdir -p $PKG_BUILD
  cd $PKG_BUILD
  mkdir bin
  cp -r $PKG_DIR/bin/* bin/
  mkdir lib
  cp -r $PKG_DIR/lib/* lib/
  mkdir config
  cp -r $PKG_DIR/config/* config/
  find . -type f -exec chmod +x {} \;
  cd $ROOT
}


make_target() {
  : not
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
   cp -r $PKG_DIR/bin/* $INSTALL/usr/bin
   chmod +x $INSTALL/usr/bin/*
  mkdir -p $INSTALL/usr/lib
    cp -r $PKG_DIR/lib/* $INSTALL/usr/lib
   chmod +x $INSTALL/usr/lib/*
  mkdir -p $INSTALL/usr/config
   cp -r $PKG_DIR/config/* $INSTALL/usr/config
}
