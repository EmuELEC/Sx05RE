PKG_NAME="qt-everywhere"
PKG_VERSION="5.9.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/official_releases/qt/5.9/$PKG_VERSION/single/$PKG_NAME-opensource-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="pcre zlib freetype libjpeg-turbo libpng tiff glib gst-plugins-base"
PKG_SOURCE_DIR="$PKG_NAME-opensource-src-$PKG_VERSION"
PKG_LONGDESC="A cross-platform application and UI framework"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr \
                           -sysroot $SYSROOT_PREFIX \
                           -hostprefix $ROOT/$BUILD \
                           -device linux-libreelec-g++ \
                           -device-option CROSS_COMPILE=${TARGET_PREFIX} \
                           -opensource -confirm-license \
                           -release \
                           -make libs \
                           -force-pkg-config \
                           -no-accessibility \
                           -no-sql-mysql \
                           -no-qml-debug \
                           -system-zlib \
                           -no-mtdev \
                           -no-gif \
                           -no-harfbuzz \
                           -no-openssl \
                           -no-libproxy \
                           -no-glib \
                           -no-pulseaudio \
                           -alsa \
                           -silent \
                           -no-cups \
                           -no-iconv \
                           -no-evdev \
                           -no-tslib \
                           -no-icu \
                           -no-strip \
                           -fontconfig \
                           -gstreamer 1.0 \
                           -no-dbus \
                           -system-libjpeg \
                           -opengl es2 \
                           -no-libudev \
                           -no-libinput \
                           -no-sql-sqlite \
                           -no-use-gold-linker \
	                   -system-libpng \
			   -optimized-qmake \
                           -reduce-exports \
                           -no-glib \
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
                           -skip qtdoc \
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
  BACKUP_STRIP=$STRIP
  #unset CC CXX AR OBJCOPY STRIP CFLAGS CXXFLAGS CPPFLAGS LDFLAGS LD RANLIB
  export QT_FORCE_PKGCONFIG=yes
  unset QMAKESPEC

 # unset CC CXX LD RANLIB AR AS CPPFLAGS CFLAGS LDFLAGS CXXFLAGS
  ./configure  -extprefix ${INSTALL}/usr/local/qt5/ $PKG_CONFIGURE_OPTS_TARGET
}

makeinstall_target() {
  # deploy to SYSROOT
  cd ${ROOT}/${BUILD}/${PKG_NAME}-${PKG_VERSION}
  make install DESTDIR=${SYSROOT_PREFIX}/usr/

  #restore strip value
  STRIP=$BACKUP_STRIP
  debug_strip ${INSTALL}/usr/local/qt5/
}


