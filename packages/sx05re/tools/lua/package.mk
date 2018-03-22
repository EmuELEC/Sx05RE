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

PKG_NAME="lua"
PKG_VERSION="5.3.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://www.lua.org/"
PKG_URL="http://www.lua.org/ftp/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain readline lua:host"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="lua: A lightweight, extensible programming language"
PKG_LONGDESC="Lua is a powerful light-weight programming language designed for extending applications. Lua is also frequently used as a general-purpose, stand-alone language."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

_MAJORVER=${PKG_VERSION%.*}

make_host() {
  : none
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
   cp -P $PKG_DIR/src/* $TOOLCHAIN/bin
}

make_target() {
  CFLAGS=`echo $CFLAGS | sed -e "s|-mcpu=cortex-a53||"`
  make CC="$CC" CFLAGS="$CFLAGS -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_5_1" linux
}

makeinstall_target() {
  make \
  TO_LIB="liblua.a liblua.so liblua.so.$_MAJORVER liblua.so.$PKG_VERSION" \
  INSTALL_DATA='cp -d' \
  INSTALL_TOP=$SYSROOT_PREFIX/usr \
  INSTALL_MAN=$SYSROOT_PREFIX/usr/share/man/man1 \
  install

  ln -sf $SYSROOT_PREFIX/usr/bin/lua $SYSROOT_PREFIX/usr/bin/lua$_MAJORVER
  ln -sf $SYSROOT_PREFIX/usr/bin/luac $SYSROOT_PREFIX/usr/bin/luac$_MAJORVER

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp -P $PKG_DIR/config/lua.pc $SYSROOT_PREFIX/usr/lib/pkgconfig/lua53.pc
  ln -sf $SYSROOT_PREFIX/usr/lib/pkgconfig/lua53.pc $SYSROOT_PREFIX/usr/lib/pkgconfig/lua.pc

  make \
  TO_LIB="liblua.a liblua.so liblua.so.$_MAJORVER liblua.so.$PKG_VERSION" \
  INSTALL_DATA='cp -d' \
  INSTALL_TOP=$INSTALL/usr \
  INSTALL_MAN=$INSTALL/usr/share/man/man1 \
  install

  ln -sf $INSTALL/usr/bin/lua $INSTALL/usr/bin/lua$_MAJORVER
  ln -sf $INSTALL/usr/bin/luac $INSTALL/usr/bin/luac$_MAJORVER
}

