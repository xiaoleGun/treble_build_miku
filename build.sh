#!/bin/bash
echo ""
echo "Miku UI Snow Unified Buildbot"
echo "Executing in 3 seconds - CTRL-C to exit"
echo ""

sleep 3
set -e

START=`date +%s`
BUILD_DATE="$(date +%Y%m%d)"
WITHOUT_CHECK_API=true
BL=$PWD/treble_build
BD=$HOME/builds
VERSION="v401"

if [ ! -d .repo ]
then
    echo "Initializing Miku UI workspace"
    repo init -u https://github.com/Project-Mushroom/platform_manifest -b snow --depth=1
    echo ""

    echo "Preparing local manifest"
    mkdir -p .repo/local_manifests
    cp ./treble_build/local_manifests_treble/manifest.xml .repo/local_manifests/miku-treble.xml
    echo ""
fi

echo "Syncing repos"
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
echo ""

if [ ! -d miku_faceunlock ]
then
    git clone https://github.com/xiaoleGun/miku_faceunlock -b snow
fi

echo "Applying patches"
bash ./treble_build/apply-patches.sh
echo ""

echo "Applying FaceUnlock patches"
bash ./miku_faceunlock/start.sh
echo ""

echo "Setting up build environment"
source build/envsetup.sh &> /dev/null
mkdir -p $BD
echo ""

echo "Treble device generation"
rm -rf device/*/sepolicy/common/private/genfs_contexts
cd device/phh/treble
git clean -fdx
bash generate.sh miku
cd ../../..
echo ""

buildTrebleApp() {
    cd treble_app
    bash build.sh release
    cp TrebleApp.apk ../vendor/hardware_overlay/TrebleApp/app.apk
    cd ..
}

buildtreble() {
    lunch miku_treble_arm64_bvS-userdebug
    make installclean
    make -j$(nproc --all) systemimage
    mv $OUT/system.img $BD/system-miku_treble_arm64_bvS.img
    sleep 1
    lunch miku_treble_arm64_bgS-userdebug
    make -j$(nproc --all) systemimage
    mv $OUT/system.img $BD/system-miku_treble_arm64_bgS.img
}

buildSasImages() {
    cd sas-creator
    sudo bash lite-adapter.sh 64 $BD/system-miku_treble_arm64_bvS.img
    cp s.img $BD/system-miku_treble_arm64_bvS-vndklite.img
    sudo bash securize.sh s.img
    cp s-secure.img $BD/system-miku_treble_arm64_bvS-vndklite-secure.img
    sudo rm -rf s.img  s-secure.img d tmp
    sudo bash lite-adapter.sh 64 $BD/system-miku_treble_arm64_bgS.img
    cp s.img $BD/system-miku_treble_arm64_bgS-vndklite.img
    sudo bash securize.sh s.img
    cp s-secure.img $BD/system-miku_treble_arm64_bgS-vndklite-secure.img
    sudo rm -rf s.img  s-secure.img d tmp
    cd ..
}

generatePackages() {
    BASE_IMAGE=$BD/system-miku_treble_arm64_bvS.img
    xz -cv $BASE_IMAGE -T0 > $BD/MikuUI-SNOW-arm64-ab-$BUILD_DATE-UNOFFICIAL.img.xz
    xz -cv ${BASE_IMAGE%.img}-vndklite.img -T0 > $BD/MikuUI-SNOW-arm64-ab-vndklite-$BUILD_DATE-UNOFFICIAL.img.xz
    xz -cv ${BASE_IMAGE%.img}-vndklite-secure.img -T0 > $BD/MikuUI-SNOW-arm64-ab-vndklite-secure-$BUILD_DATE-UNOFFICIAL.img.xz
    BASE_IMAGE=$BD/system-miku_treble_arm64_bgS.img
    xz -cv $BASE_IMAGE -T0 > $BD/MikuUI-SNOW-arm64-ab-gapps-$BUILD_DATE-UNOFFICIAL.img.xz
    xz -cv ${BASE_IMAGE%.img}-vndklite.img -T0 > $BD/MikuUI-SNOW-arm64-ab-vndklite-gapps-$BUILD_DATE-UNOFFICIAL.img.xz
    xz -cv ${BASE_IMAGE%.img}-vndklite-secure.img -T0 > $BD/MikuUI-SNOW-arm64-ab-vndklite-gapps-secure-$BUILD_DATE-UNOFFICIAL.img.xz
    rm -rf $BD/system-*.img
}

generateOtaJson() {
    prefix="MikuUI-SNOW-"
    suffix="-$BUILD_DATE-UNOFFICIAL.img.xz"
    json="{\"version\": \"$VERSION\",\"date\": \"$(date +%s -d '-6hours')\",\"variants\": ["
    find $BD -name "*.img.xz" | {
        while read file; do
            packageVariant=$(echo $(basename $file) | sed -e s/^$prefix// -e s/$suffix$//)
            case $packageVariant in
                "arm64-ab") name="miku_treble_arm64_bvS";;
                "arm64-ab-vndklite") name="miku_treble_arm64_bvS-vndklite";;
                "arm64-ab-vndklite-secure") name="miku_treble_arm64_bvS-secure";;
                "arm64-ab-gapps") name="miku_treble_arm64_bgS";;
                "arm64-ab-vndklite-gapps") name="miku_treble_arm64_bgS-vndklite";;
                "arm64-ab-vndklite-gapps-secure") name="miku_treble_arm64_bgS-secure";;
            esac
            size=$(wc -c $file | awk '{print $1}')
            url="https://github.com/xiaoleGun/treble_build/releases/download/$VERSION/$(basename $file)"
            json="${json} {\"name\": \"$name\",\"size\": \"$size\",\"url\": \"$url\"},"
        done
        json="${json%?}]}"
        echo "$json" | jq . > $BL/ota.json
    }
}

buildTrebleApp
buildtreble
buildSasImages
generatePackages
generateOtaJson

END=`date +%s`
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))
echo "Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo ""
