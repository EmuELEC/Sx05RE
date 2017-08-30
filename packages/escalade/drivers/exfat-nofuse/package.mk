# Made by github.com/escalade

PKG_NAME="exfat-nofuse"
PKG_VERSION="de4c760"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/dorimanx/exfat-nofuse"
PKG_URL="https://github.com/dorimanx/exfat-nofuse/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Linux non-fuse read/write kernel driver for exFat"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make KDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp *.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
}
