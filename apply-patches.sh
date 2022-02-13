#!/bin/bash

SOURCE_DIR=$PWD
PHH=${SOURCE_DIR}/treble_build/patches/phh
Andy=${SOURCE_DIR}/treble_build/patches/Andy
extra=${SOURCE_DIR}/treble_build/patches/extra

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
for i in {0001..0003}
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

## AndyCGYans patches ##

#build_make
DISPLAY_MSG=1
cp -r ${Andy}/build_make ${SOURCE_DIR}/build/make/andy && cd ${SOURCE_DIR}/build/make
for i in {0001..0002}
do apply_patches build/make andy $i
done

#device_phh_treble
DISPLAY_MSG=1
cp -r ${Andy}/device_phh_treble ${SOURCE_DIR}/device/phh/treble/andy && cd ${SOURCE_DIR}/device/phh/treble
for i in {0001..0003}
do apply_patches device/phh/treble andy $i
done

#frameworks_base
DISPLAY_MSG=1
cp -r ${Andy}/frameworks_base ${SOURCE_DIR}/frameworks/base/andy && cd ${SOURCE_DIR}/frameworks/base
for i in {0001..0002}
do apply_patches frameworks/base andy $i
done

#frameworks_native
DISPLAY_MSG=1
cp -r ${Andy}/frameworks_native ${SOURCE_DIR}/frameworks/native/andy && cd ${SOURCE_DIR}/frameworks/native
for i in {0001..0001}
do apply_patches frameworks/native andy $i
done

#system_core
DISPLAY_MSG=1
cp -r ${Andy}/system_core ${SOURCE_DIR}/system/core/andy && cd ${SOURCE_DIR}/system/core
for i in {0001..0002}
do apply_patches system/core andy $i
done

#system_sepolicy
DISPLAY_MSG=1
cp -r ${Andy}/system_sepolicy ${SOURCE_DIR}/system/sepolicy/andy && cd ${SOURCE_DIR}/system/sepolicy
for i in {0001..0001}
do apply_patches system/sepolicy andy $i
done

#vendor_miku
DISPLAY_MSG=1
cp -r ${Andy}/vendor_miku ${SOURCE_DIR}/vendor/miku/andy && cd ${SOURCE_DIR}/vendor/miku
for i in {0001..0001}
do apply_patches vendor/miku andy $i
done

## Extra patches ##

#build_make
DISPLAY_MSG=1
cp -r ${extra}/build_make ${SOURCE_DIR}/build/make/extra && cd ${SOURCE_DIR}/build/make
for i in {0001..0002}
do apply_patches build/make extra $i
done

#device_phh_treble
DISPLAY_MSG=1
cp -r ${extra}/device_phh_treble ${SOURCE_DIR}/device/phh/treble/extra && cd ${SOURCE_DIR}/device/phh/treble
for i in {0001..0008}
do apply_patches device/phh/treble extra $i
done

#packages_apps_settings
DISPLAY_MSG=1
cp -r ${extra}/packages_apps_Settings ${SOURCE_DIR}/packages/apps/Settings/extra && cd ${SOURCE_DIR}/packages/apps/Settings/
for i in {0001..0001}
do apply_patches packages/apps/Settings extra $i
done

#system_core
DISPLAY_MSG=1
cp -r ${extra}/system_core ${SOURCE_DIR}/system/core/extra && cd ${SOURCE_DIR}/system/core
for i in {0001..0001}
do apply_patches system/core extra $i
done

#system_vold
DISPLAY_MSG=1
cp -r ${extra}/system_vold ${SOURCE_DIR}/system/vold/extra && cd ${SOURCE_DIR}/system/vold
for i in {0001..0007}
do apply_patches system/vold extra $i
done

#treble_app
DISPLAY_MSG=1
cp -r ${extra}/treble_app ${SOURCE_DIR}/treble_app/extra && cd ${SOURCE_DIR}/treble_app
for i in {0001..0003}
do apply_patches treble_app extra $i
done

#vendor/miku
DISPLAY_MSG=1
cp -r ${extra}/vendor_miku ${SOURCE_DIR}/vendor/miku/extra && cd ${SOURCE_DIR}/vendor/miku
for i in {0001..0001}
do apply_patches vendor/miku extra $i
done

#vendor/vndk-tests
DISPLAY_MSG=1
cp -r ${extra}/vendor_vndk-tests ${SOURCE_DIR}/vendor/vndk-tests/extra && cd ${SOURCE_DIR}/vendor/vndk-tests
for i in {0001..0001}
do apply_patches vendor/vndk-tests extra $i
done

echo "Clean UP"
rm -rf ${SOURCE_DIR}/build/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/bionic/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/device/phh/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/external/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/frameworks/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/frameworks/opt/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/hardware/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/packages/apps/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/system/*/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/treble_app/{andy,extra,phh}
rm -rf ${SOURCE_DIR}/vendor/*/{andy,extra,phh}
