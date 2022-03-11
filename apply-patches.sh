#!/bin/bash

SOURCE_DIR=$PWD
PHH=${SOURCE_DIR}/treble_build/patches/phh
personal=${SOURCE_DIR}/treble_build/patches/personal

RED_BOLD="\e[1;31m"
RED_BOLD_HIGHLIGHT="\e[1;41m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

apply_patches() {
  if [ "$PWD" == "${SOURCE_DIR}/$1" ]; then
     git am $2/$3*
  elif [ ${DISPLAY_MSG} == 1 ]; then
     echo -e "${RED_BOLD_HIGHLIGHT}Current Directory:${ENDCOLOR} ${YELLOW} $PWD ≠ ${SOURCE_DIR}/$1${ENDCOLOR}"
     echo -e "${RED_BOLD}Skipping patches for $1 ${ENDCOLOR}"
     DISPLAY_MSG="0"
  fi
}

## PHH patches ##

#platform_bionic
DISPLAY_MSG=01
cp -r ${PHH}/platform_bionic ${SOURCE_DIR}/bionic/phh && cd ${SOURCE_DIR}/bionic
for i in {0001..0001}
do apply_patches bionic phh $i
done

#platform_bootable_recovery
DISPLAY_MSG=1
cp -r ${PHH}/platform_bootable_recovery ${SOURCE_DIR}/bootable/recovery/phh && cd ${SOURCE_DIR}/bootable/recovery
for i in {0001..0001}
do apply_patches bootable/recovery phh $i
done

#platform_external_selinux
DISPLAY_MSG=1
cp -r ${PHH}/platform_external_selinux ${SOURCE_DIR}/external/selinux/phh && cd ${SOURCE_DIR}/external/selinux
for i in {0001..0007}
do apply_patches external/selinux phh $i
done

#platform_frameworks_av
DISPLAY_MSG=1
cp -r ${PHH}/platform_frameworks_av ${SOURCE_DIR}/frameworks/av/phh && cd ${SOURCE_DIR}/frameworks/av
for i in {0001..0020}
do apply_patches frameworks/av phh $i
done

#platform_frameworks_base
DISPLAY_MSG=1
cp -r ${PHH}/platform_frameworks_base ${SOURCE_DIR}/frameworks/base/phh && cd ${SOURCE_DIR}/frameworks/base
for i in {0001..0026}
do apply_patches frameworks/base phh $i
done

#platform_frameworks_native
DISPLAY_MSG=1
cp -r ${PHH}/platform_frameworks_native ${SOURCE_DIR}/frameworks/native/phh && cd ${SOURCE_DIR}/frameworks/native
for i in {0001..0013}
do apply_patches frameworks/native phh $i
done

#platform_frameworks_opt_telephony
DISPLAY_MSG=1
cp -r ${PHH}/platform_frameworks_opt_telephony ${SOURCE_DIR}/frameworks/opt/telephony/phh && cd ${SOURCE_DIR}/frameworks/opt/telephony
for i in {0001..0005}
do apply_patches frameworks/opt/telephony phh $i
done

#platform_hardware_interfaces
DISPLAY_MSG=1
cp -r ${PHH}/platform_hardware_interfaces ${SOURCE_DIR}/hardware/interfaces/phh && cd ${SOURCE_DIR}/hardware/interfaces
for i in {0001..0001}
do apply_patches hardware/interfaces phh $i
done

#platform_packages_apps_Bluetooth
DISPLAY_MSG=1
cp -r ${PHH}/platform_packages_apps_Bluetooth ${SOURCE_DIR}/packages/apps/Bluetooth/phh && cd ${SOURCE_DIR}/packages/apps/Bluetooth
for i in {0001..0001}
do apply_patches packages/apps/Bluetooth phh $i
done

#platform_packages_apps_Settings
DISPLAY_MSG=1
cp -r ${PHH}/platform_packages_apps_Settings ${SOURCE_DIR}/packages/apps/Settings/phh && cd ${SOURCE_DIR}/packages/apps/Settings
for i in {0001..0001}
do apply_patches packages/apps/Settings phh $i
done

#platform_packages_modules_Wifi
DISPLAY_MSG=1
cp -r ${PHH}/platform_packages_modules_Wifi ${SOURCE_DIR}/packages/modules/Wifi/phh && cd ${SOURCE_DIR}/packages/modules/Wifi
for i in {0001..0001}
do apply_patches packages/modules/Wifi phh $i
done

#platform_system_bpf
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_bpf ${SOURCE_DIR}/system/bpf/phh && cd ${SOURCE_DIR}/system/bpf
for i in {0001..0001}
do apply_patches system/bpf phh $i
done

#platform_system_bt
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_bt ${SOURCE_DIR}/system/bt/phh && cd ${SOURCE_DIR}/system/bt
for i in {0001..0005}
do apply_patches system/bt phh $i
done

#platform_system_core
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_core ${SOURCE_DIR}/system/core/phh && cd ${SOURCE_DIR}/system/core
for i in {0001..0005}
do apply_patches system/core phh $i
done

#platform_system_extras
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_extras ${SOURCE_DIR}/system/extras/phh && cd ${SOURCE_DIR}/system/extras
for i in {0001..0001}
do apply_patches system/extras phh $i
done

#platform_system_linkerconfig
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_linkerconfig ${SOURCE_DIR}/system/linkerconfig/phh && cd ${SOURCE_DIR}/system/linkerconfig
for i in {0001..0001}
do apply_patches system/linkerconfig phh $i
done

#platform_system_netd
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_netd ${SOURCE_DIR}/system/netd/phh && cd ${SOURCE_DIR}/system/netd
for i in {0001..0003}
do apply_patches system/netd phh $i
done

#platform_system_nfc
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_nfc ${SOURCE_DIR}/system/nfc/phh && cd ${SOURCE_DIR}/system/nfc
for i in {0001..0001}
do apply_patches system/nfc phh $i
done

#platform_system_vold
DISPLAY_MSG=1
cp -r ${PHH}/platform_system_vold ${SOURCE_DIR}/system/vold/phh && cd ${SOURCE_DIR}/system/vold
for i in {0001..0007}
do apply_patches system/vold phh $i
done

## personal patches ##

#build_make
DISPLAY_MSG=1
cp -r ${personal}/build_make ${SOURCE_DIR}/build/make/personal && cd ${SOURCE_DIR}/build/make
for i in {0001..0004}
do apply_patches build/make personal $i
done

#device_phh_treble
DISPLAY_MSG=1
cp -r ${personal}/device_phh_treble ${SOURCE_DIR}/device/phh/treble/personal && cd ${SOURCE_DIR}/device/phh/treble
for i in {0001..0012}
do apply_patches device/phh/treble personal $i
done

#frameworks_base
DISPLAY_MSG=1
cp -r ${personal}/frameworks_base ${SOURCE_DIR}/frameworks/base/personal && cd ${SOURCE_DIR}/frameworks/base
for i in {0001..0008}
do apply_patches frameworks/base personal $i
done

#frameworks_native
DISPLAY_MSG=1
cp -r ${personal}/frameworks_native ${SOURCE_DIR}/frameworks/native/personal && cd ${SOURCE_DIR}/frameworks/native
for i in {0001..0001}
do apply_patches frameworks/native personal $i
done

#packages_apps_settings
DISPLAY_MSG=1
cp -r ${personal}/packages_apps_Settings ${SOURCE_DIR}/packages/apps/Settings/personal && cd ${SOURCE_DIR}/packages/apps/Settings/
for i in {0001..0001}
do apply_patches packages/apps/Settings personal $i
done

#system_core
DISPLAY_MSG=1
cp -r ${personal}/system_core ${SOURCE_DIR}/system/core/personal && cd ${SOURCE_DIR}/system/core
for i in {0001..0005}
do apply_patches system/core personal $i
done

#system_sepolicy
DISPLAY_MSG=1
cp -r ${personal}/system_sepolicy ${SOURCE_DIR}/system/sepolicy/personal && cd ${SOURCE_DIR}/system/sepolicy
for i in {0001..0001}
do apply_patches system/sepolicy personal $i
done

#system_vold
DISPLAY_MSG=1
cp -r ${personal}/system_vold ${SOURCE_DIR}/system/vold/personal && cd ${SOURCE_DIR}/system/vold
for i in {0001..0007}
do apply_patches system/vold personal $i
done

#treble_app
DISPLAY_MSG=1
cp -r ${personal}/treble_app ${SOURCE_DIR}/treble_app/personal && cd ${SOURCE_DIR}/treble_app
for i in {0001..0003}
do apply_patches treble_app personal $i
done

#vendor/miku
DISPLAY_MSG=1
cp -r ${personal}/vendor_miku ${SOURCE_DIR}/vendor/miku/personal && cd ${SOURCE_DIR}/vendor/miku
for i in {0001..0002}
do apply_patches vendor/miku personal $i
done

#vendor/vndk-tests
DISPLAY_MSG=1
cp -r ${personal}/vendor_vndk-tests ${SOURCE_DIR}/vendor/vndk-tests/personal && cd ${SOURCE_DIR}/vendor/vndk-tests
for i in {0001..0001}
do apply_patches vendor/vndk-tests personal $i
done

rm -rf ${SOURCE_DIR}/build/*/{personal,phh}
rm -rf ${SOURCE_DIR}/bionic/*/{personal,phh}
rm -rf ${SOURCE_DIR}/device/phh/*/{personal,phh}
rm -rf ${SOURCE_DIR}/external/*/{personal,phh}
rm -rf ${SOURCE_DIR}/frameworks/*/{personal,phh}
rm -rf ${SOURCE_DIR}/frameworks/opt/*/{personal,phh}
rm -rf ${SOURCE_DIR}/hardware/*/{personal,phh}
rm -rf ${SOURCE_DIR}/packages/apps/*/{personal,phh}
rm -rf ${SOURCE_DIR}/system/*/{personal,phh}
rm -rf ${SOURCE_DIR}/treble_app/{personal,phh}
rm -rf ${SOURCE_DIR}/vendor/*/{personal,phh}
