################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
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

PKG_NAME="gst-plugins-good"
PKG_VERSION="1.12.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/GStreamer/gst-plugins-base"
PKG_URL="https://gstreamer.freedesktop.org/src/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer"
PKG_PRIORITY="optional"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Gstreamer"
PKG_LONGDESC="Gstreamer"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no" 

#post_unpack() {
#  rm -rf $BUILD/$PKG_NAME-*/
#  git clone https://github.com/GStreamer/gst-plugins-base.git $BUILD/$PKG_NAME-$PKG_VERSION/
#  cd $BUILD/$PKG_NAME-$PKG_VERSION/
#  git checkout $PKG_VERSION
#  git submodule update --init
#  cd $ROOT
#}

pre_configure_target() {
  strip_lto
}

#configure_target() {
#export PKG_CONFIG_PATH="/home/sg/sx05re/Kszaq/build.Sx05RE-S905.arm-1.6/gstreamer-5f5caff/pkgconfig"
#export LDFLAGS="-L$SYSROOT_PREFIX/usr/lib" \
#CFLAGS="-I $SYSROOT_PREFIX/usr/include/ -I $SYSROOT_PREFIX/usr/include/gstreamer-1.0/" \
#CPPFLAGS="-I $SYSROOT_PREFIX/usr/include/ -I $SYSROOT_PREFIX/usr/include/gstreamer-1.0/"

#./autogen.sh  --prefix="/usr" \
#     --host="$TARGET_NAME" \
#      --disable-gtk-doc \
#      --includedir="$SYSROOT_PREFIX/usr/include/" \
#      --libdir="$SYSROOT_PREFIX/usr/lib"\
#      --disable-shared --enable-static

#}

#make_target() {
#make CFLAGS+="-fPIC -Wno-missing-include-dirs -Wno-error -Wno-redundant-decls -I $SYSROOT_PREFIX/usr/include/ -I $SYSROOT_PREFIX/usr/include/#gstreamer-1.0/gst" \
#      CPPFLAGS+="-fPIC -Wno-missing-include-dirs -Wno-error -Wno-redundant-decls -I $SYSROOT_PREFIX/usr/include/ -I $SYSROOT_PREFIX/usr/#include/gstreamer-1.0/gst" \
#CXXFLAGS+="-Wno-redundant-decls" LDFLAGS+="-L$SYSROOT_PREFIX/usr/lib -fPIC"
#}
