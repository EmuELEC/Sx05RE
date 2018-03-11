################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
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
PKG_NAME="qt-everywhere"
PKG_VERSION="5.9.4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/official_releases/qt/5.9/$PKG_VERSION/single/$PKG_NAME-opensource-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="pcre2 zlib freetype libjpeg-turbo libpng tiff glib gst-plugins-base gst-libav gst-plugins-good"
PKG_SOURCE_DIR="$PKG_NAME-opensource-src-$PKG_VERSION"
PKG_LONGDESC="A cross-platform application and UI framework"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr \
            -sysroot $SYSROOT_PREFIX \
            -hostprefix $ROOT/$BUILD \
            -device linux-libreelec-g++ \
            -device-option CROSS_COMPILE=${TARGET_PREFIX} \
            -fontconfig \
			-opensource \
			-confirm-license \
			-release \
			-strip \
			-no-rpath \
			-make libs \
			-no-pch \
			-opengl es2 \
			-gstreamer 1.0 \
			-no-xcb \
			-no-feature-accessibility \
			-no-feature-action \
			-no-feature-clipboard \
			-no-feature-cssparser \
			-no-feature-cursor \
			-no-feature-dbus \
			-no-feature-directfb \
			-no-feature-draganddrop \
			-no-feature-ftp \
			-no-feature-gbm \
			-no-feature-gestures \
			-no-feature-glib \
			-no-feature-icu \
			-no-feature-im \
			-no-feature-image_heuristic_mask \
			-no-feature-image_text \
			-no-feature-imageformat_bmp \
			-no-feature-imageformat_ppm \
			-no-feature-imageformat_xpm \
			-no-feature-linux_v4l \
			-no-feature-linuxfb \
			-no-feature-localserver \
			-no-feature-mimetype \
			-no-feature-mirclient \
			-no-feature-mtdev \
			-no-feature-pdf \
			-no-feature-picture \
			-no-feature-proxymodel \
			-no-feature-qml-debug \
			-no-feature-qml-profiler \
			-no-feature-quick-designer \
			-no-feature-sctp \
			-no-feature-sessionmanager \
			-no-feature-sharedmemory \
			-no-feature-shortcut \
			-no-feature-sql \
			-no-feature-systemsemaphore \
			-no-feature-systemtrayicon \
			-no-feature-tabletevent \
			-no-feature-texthtmlparser \
			-no-feature-textodfwriter \
			-no-feature-timezone \
			-no-feature-tslib \
			-no-feature-udpsocket \
			-no-feature-validator \
			-no-feature-vnc \
			-no-feature-widgets \
			-skip qtxmlpatterns \
            -skip qtx11extras \
            -skip qtwinextras \
            -skip qtspeech \
            -skip qtdatavis3d \
            -skip qtcharts \
            -skip qtandroidextras \
            -skip qt3d \
            -skip qtlocation \
            -skip qtmacextras \
            -skip qtdoc \
            -skip qtdatavis3d \
            -skip qtpurchasing \
            -skip qtnetworkauth \
            -skip qtscript \
            -skip qtwebengine \
            -skip qtwebview \
            -skip qtactiveqt \
            -skip qtcanvas3d \
            -skip qtconnectivity \
            -skip qtquickcontrols \
            -skip qtremoteobjects \
            -skip qtscxml \
            -skip qtsensors \
            -skip qtserialbus \
            -skip qtserialport \
            -skip qttranslations \
            -skip qtvirtualkeyboard \
            -skip qtwayland \
            -skip qtwebchannel \
			-skip qtwebsockets"


configure_target() {
  QMAKE_CONF_DIR="qtbase/mkspecs/devices/linux-libreelec-g++"
  QMAKE_CONF="${QMAKE_CONF_DIR}/qmake.conf"

  cd ..
  mkdir -p $QMAKE_CONF_DIR
  echo "MAKEFILE_GENERATOR       = UNIX" > $QMAKE_CONF
  echo "CONFIG                  += incremental" >> $QMAKE_CONF
  echo "QMAKE_INCREMENTAL_STYLE  = sublib" >> $QMAKE_CONF
  echo "include(../../common/linux.conf)" >> $QMAKE_CONF
  echo "include(../../common/gcc-base-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/g++-unix.conf)" >> $QMAKE_CONF
  echo "load(device_config)" >> $QMAKE_CONF
  echo "QMAKE_CC                = $CC" >> $QMAKE_CONF
  echo "QMAKE_CXX               = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK              = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK_SHLIB        = $CXX" >> $QMAKE_CONF
  echo "QMAKE_AR                = $AR cqs" >> $QMAKE_CONF
  echo "QMAKE_OBJCOPY           = $OBJCOPY" >> $QMAKE_CONF
  echo "QMAKE_NM                = $NM -P" >> $QMAKE_CONF
  echo "QMAKE_STRIP             = $STRIP" >> $QMAKE_CONF
  echo "QMAKE_CFLAGS = $CFLAGS" >> $QMAKE_CONF
  echo "QMAKE_CXXFLAGS = $CXXFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LFLAGS = $LDFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LIBS_EGL += -lMali" >> $QMAKE_CONF
  echo "EGLFS_DEVICE_INTEGRATION = eglfs_mali" >> $QMAKE_CONF
  echo "load(qt_config)" >> $QMAKE_CONF
  echo '#include "../../linux-g++/qplatformdefs.h"' >> $QMAKE_CONF_DIR/qplatformdefs.h

  # Undefines compiler options
  # BACKUP_STRIP=$STRIP
  #unset CC CXX AR OBJCOPY STRIP CFLAGS CXXFLAGS CPPFLAGS LDFLAGS LD RANLIB
  export QT_FORCE_PKGCONFIG=yes
  unset QMAKESPEC

   ./configure  -extprefix ${INSTALL}/usr/local/qt5/ $PKG_CONFIGURE_OPTS_TARGET
}

makeinstall_target() {
  # deploy to SYSROOT
  cd ${BUILD}/${PKG_NAME}-${PKG_VERSION}
  make install DESTDIR=${SYSROOT_PREFIX}/usr/

  #restore strip value
  #STRIP=$BACKUP_STRIP
  #debug_strip ${INSTALL}/usr/local/qt5/
}
