#!/usr/bin/env bash

device="${1:-astroslide}"
chipset="${2:-mt6873}"
branch="${3:-stock-android}"
config=""
sha=""
if [ $# -eq 3 ]; then
	sha="${3}"
fi

case "${device}" in
astroslide)
	config="k6873v1_64_defconfig"
	chipset="mt6873"
	;;
cosmocom)
	config="k71v1_64_bsp_defconfig"
	chipset="mt6771"
	;;
geminipda)
	config="aeon6797_6m_n_defconfig"
	chipset="mt6797"
	;;
*)
	echo "Unknown device: ${device}"
	exit 1
	;;
esac

if [ -z "${sha}" ]; then
	00_fetch_kernel.sh "${chipset}" "${branch}"
else
	00_fetch_kernel.sh "${chipset}" "${branch}" "${sha}"
fi

01_build_kernel.sh "${config}"
02_package-kernel.sh
03_fixup_kernel.sh
