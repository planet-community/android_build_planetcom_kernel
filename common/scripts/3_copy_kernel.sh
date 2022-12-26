#!/usr/bin/env bash

ls -l /usr/src/kernel/out/arch/arm64/boot/

cp -v \
  /usr/src/kernel/out/arch/arm64/boot/Image.gz \
  /out/
