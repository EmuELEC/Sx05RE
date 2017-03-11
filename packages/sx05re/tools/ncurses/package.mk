################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="ncurses"
PKG_VERSION="6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://ftp.gnu.org/gnu/ncurses/"
PKG_URL="http://ftp.gnu.org/gnu/ncurses/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="sx05re/tools"
PKG_SHORTDESC="ncurses"
PKG_LONGDESC="The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4),"
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

#PKG_CONFIGURE_OPTS_TARGET="--disable-sdl --without-x"

make_target() {
#CFLAGS="$CFLAGS -mfpu=neon-fp-armv8"
#CFLAGS="$CFLAGS -mfpu=neon-vfpv4 -march=armv7-a"
#./autogen.sh

./configure --enable-widec
make 

#mkdir -p $INSTALL/usr/share/advance
#   cp -r $PKG_DIR/config/* $INSTALL/usr/share/advance/
#mkdir -p $INSTALL/usr/bin
#   cp -r $PKG_DIR/bin/* $INSTALL/usr/bin
#chmod +x $INSTALL/usr/bin/advmame.sh
}



post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}

