#!/bin/bash

echo "ATTENTION!"
echo "Make sure the 'wget' and 'zstd' packages are installed before running this script."
echo "Press [Enter] to continue."
read

# You can choose another mirror at https://www.archlinux.org/mirrorlist/all/
arch_mirror=https://mirror.rackspace.com

arch_core=(
  icu-*.tar.zst
  pcre2-*.tar.zst
)

arch_extra=(
  qt5-base-*.tar.zst
  qt5-datavis3d-*.tar.zst
  qt5-script-*.tar.zst
  qt5-svg-*.tar.zst
  qt5-xmlpatterns-*.tar.zst
  double-conversion-*.tar.zst
  md4c-*.tar.zst
  gsl-*.tar.zst
  libxcb-*.tar.zst
)

# Download packages
for i in "${arch_core[@]}"; do
  wget -r -nd --no-parent -A "${i}" ${arch_mirror}/archlinux/core/os/x86_64/
  tar -I zstd -xf ${i}
done

for i in "${arch_extra[@]}"; do
  wget -r -nd --no-parent -A "${i}" ${arch_mirror}/archlinux/extra/os/x86_64/
  tar -I zstd -xf ${i}
done

# Download AlphaPlot 1.011
wget https://github.com/narunlifescience/AlphaPlot/releases/download/1.011/alphaplot-1.011-alpha-release-x86_64.pkg.tar.xz
tar -xf alphaplot-1.011-alpha-release-x86_64.pkg.tar.xz 

# Remove files (optional)
removefiles=(
  .BUILDINFO
  .MTREE
  .PKGINFO
  .INSTALL
  *.zst
  *.tar.xz
)
for i in "${removefiles[@]}"; do
  rm -f ${i}
done

# Move files
mkdir alphaplot && mv usr alphaplot/

# Download pkg2appimage
wget https://raw.githubusercontent.com/probonopd/AppImages/master/pkg2appimage
