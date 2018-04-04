find . -type f -name "*.mk" -exec sed -i -e 's/PKG_IS_ADDON="no"/PKG_IS_ADDON="no"\'$'\nPKG_TOOLCHAIN="make"/g' {} \;
find . -type f -name "*.mk" -exec sed -i -e 's/strip_lto/echo strip_lto/g' {} \;
find . -type f -name "*.mk" -exec sed -i -e 's/strip_gold/echo strip_gold/g' {} \;


