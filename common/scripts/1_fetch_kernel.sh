#!/usr/bin/env bash

# fetch kernel sources
git clone \
  -b ${1:-stock-android} \
  https://github.com/PCLineageOS-Ports/android_kernel_planet_mt6873.git \
  /usr/src/kernel

# git reset to specific git commit
if [ $# -eq 2 ]; then
  pushd /usr/src/kernel
    git reset --hard "${2}"
  popd
fi
