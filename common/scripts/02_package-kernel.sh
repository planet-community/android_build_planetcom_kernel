#!/usr/bin/env bash

if [ ! -f "/var/tmp/input_boot.img" ]; then
	echo "Error: /var/tmp/input_boot.img not found"
	exit 1
fi

# unpack boot.img
mkdir -p /var/tmp/bootimg
/opt/unpackbootimg/unpackbootimg -i "${1:-/var/tmp/input_boot.img}" -o /var/tmp/bootimg

# overwrite kernel
cp \
	/usr/src/kernel/out/arch/arm64/boot/Image.gz \
	/var/tmp/bootimg/boot.img-kernel

# repack boot.img
/opt/unpackbootimg/mkbootimg \
	--base "(< /var/tmp/bootimg/boot.img-base)" \
	--board "(< /var/tmp/bootimg/boot.img-board)" \
	--cmdline "(< /var/tmp/bootimg/boot.img-cmdline)" \
	--dtb /var/tmp/bootimg/boot.img-dtb \
	--dtb_offset "(< /var/tmp/bootimg/boot.img-dtb_offset)" \
	--hashtype "(< /var/tmp/bootimg/boot.img-hashtype)" \
	--header_version "(< /var/tmp/bootimg/boot.img-header_version)" \
	--kernel /var/tmp/bootimg/boot.img-kernel \
	--kernel_offset "(< /var/tmp/bootimg/boot.img-kernel_offset)" \
	--os_patch_level "(< /var/tmp/bootimg/boot.img-os_patch_level)" \
	--os_version "(< /var/tmp/bootimg/boot.img-os_version)" \
	--pagesize "(< /var/tmp/bootimg/boot.img-pagesize)" \
	--ramdisk /var/tmp/bootimg/boot.img-ramdisk \
	--ramdisk_offset "(< /var/tmp/bootimg/boot.img-ramdisk_offset)" \
	--second_offset "(< /var/tmp/bootimg/boot.img-second_offset)" \
	--tags_offset "(< /var/tmp/bootimg/boot.img-tags_offset)" \
	--output /out/boot.img
