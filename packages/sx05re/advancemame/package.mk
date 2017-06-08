################################################################################
#      This file is part of sx05re
#      no copyright, do as you please :)4f3880d
################################################################################

PKG_NAME="advancemame"
PKG_VERSION="480ad7c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/amadvance/advancemame"
PKG_URL="https://github.com/amadvance/advancemame/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="advancemame-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain freetype slang"
PKG_SECTION="sx05re/mod"
PKG_SHORTDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_LONGDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


make_target() {
#CFLAGS="$CFLAGS -mfpu=neon-fp-armv8"
#CFLAGS="$CFLAGS -mfpu=neon-vfpv4 -march=armv7-a"
./autogen.sh
#./configure --host=arm --enable-fb --enable-sdl2 --enable-freetype --prefix=$INSTALL/usr --with-freetype-prefix=$SYSROOT_PREFIX/usr/ --with-sdl2-prefix=$SYSROOT_PREFIX/usr/ --enable-slang
 if [ "$TARGET_ARCH" == "arm" ]; then
./configure --host=arm --enable-fb --enable-freetype --prefix=$INSTALL/usr --with-freetype-prefix=$SYSROOT_PREFIX/usr/ --enable-slang
else
./configure --host=aarch64 --enable-fb --enable-freetype --prefix=$INSTALL/usr --with-freetype-prefix=$SYSROOT_PREFIX/usr/ --enable-slang
fi
 
make 
mkdir -p $INSTALL/usr/share/advance
   cp -r $PKG_DIR/config/* $INSTALL/usr/share/advance/
mkdir -p $INSTALL/usr/bin
   cp -r $PKG_DIR/bin/* $INSTALL/usr/bin
chmod +x $INSTALL/usr/bin/advmame.sh
}
