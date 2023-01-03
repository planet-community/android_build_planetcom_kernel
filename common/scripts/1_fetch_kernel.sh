#!/usr/bin/env bash

# fetch kernel sources
git clone \
  -b ${2:-stock-android} \
  https://github.com/PCLineageOS-Ports/${1:-android_kernel_planet_mt6873} \
  /usr/src/kernel

# git reset to specific git commit
if [ $# -eq 3 ]; then
  pushd /usr/src/kernel
    git reset --hard "${3}"
  popd
fi
