################################################################################
#      This file is part of sx05re
#      no copyright, do as you please :)4f3880d
################################################################################

PKG_NAME="advancemame"
PKG_VERSION="339dcf4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/amadvance/advancemame"
PKG_URL="https://github.com/amadvance/advancemame/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="advancemame-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain freetype slang alsa"
PKG_SECTION="sx05re/mod"
PKG_SHORTDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_LONGDESC="A MAME and MESS port with an advanced video support for Arcade Monitors, TVs, and PC Monitors "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
cp -r $PKG_DIR/.version $PKG_BUILD
}

make_target() {
./autogen.sh
./configure --prefix=/usr --datadir=/usr/share/ --datarootdir=/usr/share/ --host=arm --enable-fb --enable-freetype --with-freetype-prefix=$SYSROOT_PREFIX/usr/ --enable-slang
make 
}

makeinstall_target() {
 : not
}

post_make_target() { 
# Cleanup unnecessary files
mkdir -p $INSTALL/usr/share/advance
   cp -r $PKG_DIR/config/* $INSTALL/usr/share/advance/
mkdir -p $INSTALL/usr/bin
   cp -r $PKG_DIR/bin/* $INSTALL/usr/bin
chmod +x $INSTALL/usr/bin/advmame.sh

cp -r $PKG_BUILD/obj/mame/generic/blend/advmame $INSTALL/usr/bin
cp -r $PKG_BUILD/support/category.ini $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/sysinfo.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/history.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/hiscore.dat $INSTALL/usr/share/advance
cp -r $PKG_BUILD/support/event.dat $INSTALL/usr/share/advance
}
