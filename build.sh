#!/bin/bash
echo
echo "-----------------------------------------"
echo "      Miku UI TDA Treble Buildbot        "
echo "                  by                     "
echo "               xiaoleGun                 "
echo " Executing in 3 seconds - CTRL-C to exit "
echo "-----------------------------------------"
echo

sleep 3
set -e

BL=$(cd $(dirname $0);pwd)
BD=$HOME/builds
VERSION="TDA_0.3.1"

initrepo() {
if [ ! -d .repo ]
then
    echo ""
    echo "--> Initializing Miku UI workspace"
    echo ""
    repo init -u https://github.com/Miku-UI/manifesto -b TDA --depth=1
fi

if [ -d .repo ] && [ ! -f .repo/local_manifests/miku-treble.xml ] ;then
     echo ""
     echo "--> Preparing local manifest"
     echo ""
     rm -rf .repo/local_manifests
     mkdir -p .repo/local_manifests
     cp $BL/local_manifests_treble/manifest.xml .repo/local_manifests/miku-treble.xml
fi
}

syncrepo() {
echo ""
echo "--> Syncing repos"
echo ""
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
}

applypatches() {
patches="$(readlink -f -- $1)"
tree="$2"

for project in $(cd $patches/patches/$tree; echo *);do
	p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
	[ "$p" == treble/app ] && p=treble_app
	[ "$p" == vendor/hardware/overlay ] && p=vendor/hardware_overlay
	pushd $p
	for patch in $patches/patches/$tree/$project/*.patch;do
		git am $patch || exit
	done
	popd
    done
}

applyingpatches() {
echo ""
echo "--> Applying prerequisite patches"
echo ""
applypatches $BL prerequisite
echo ""
echo "--> Applying PHH patches"
echo ""
applypatches $BL phh
echo ""
echo "--> Applying Peter patches"
echo ""
applypatches $BL peter
echo ""
echo "--> Applying personal patches"
echo ""
applypatches $BL personal
}

initenvironment() {
echo ""
echo "--> Setting up build environment"
echo ""
source build/envsetup.sh &> /dev/null
mkdir -p $BD

echo ""
echo "--> Treble device generation"
echo ""
rm -rf device/*/sepolicy/common/private/genfs_contexts
cd device/phh/treble
git clean -fdx
bash generate.sh miku
cd ../../..
}

buildTrebleApp() {
    echo ""
    echo "--> Building treble_app"
    echo ""
    cd treble_app
    bash build.sh release
    cp TrebleApp.apk ../vendor/hardware_overlay/TrebleApp/app.apk
    cd ..
}

buildtreble() {
    echo ""
    echo "--> Building treble image"
    echo ""
    lunch miku_treble_arm64_bvN-userdebug
    make installclean
    make -j$(nproc --all) systemimage
    mv $OUT/system.img $BD/system-miku_treble_arm64_bvN.img
    sleep 1
    lunch miku_treble_arm64_bgN-userdebug
    make -j$(nproc --all) systemimage
    mv $OUT/system.img $BD/system-miku_treble_arm64_bgN.img
}

buildSasImages() {
    echo ""
    echo "--> Building vndklite variant"
    echo ""
    cd sas-creator
    sudo bash lite-adapter.sh 64 $BD/system-miku_treble_arm64_bvN.img
    cp s.img $BD/system-miku_treble_arm64_bvN-vndklite.img
    sudo rm -rf s.img d tmp
    sudo bash lite-adapter.sh 64 $BD/system-miku_treble_arm64_bgN.img
    cp s.img $BD/system-miku_treble_arm64_bgN-vndklite.img
    sudo rm -rf s.img d tmp
    cd ..
}

generatePackages() {
    echo ""
    echo "--> Generating packages"
    echo ""
    BASE_IMAGE=$BD/system-miku_treble_arm64_bvN.img
    mkdir --parents $BD/dsu/vanilla/; mv $BASE_IMAGE $BD/dsu/vanilla/system.img
    zip -j -v $BD/MikuUI-$VERSION-arm64-ab-$BUILD_DATE-UNOFFICIAL.zip $BD/dsu/vanilla/system.img
    mkdir --parents $BD/dsu/vanilla-vndklite/; mv ${BASE_IMAGE%.img}-vndklite.img $BD/dsu/vanilla-vndklite/system.img
    zip -j -v $BD/MikuUI-$VERSION-arm64-ab-vndklite-$BUILD_DATE-UNOFFICIAL.zip $BD/dsu/vanilla-vndklite/system.img
    BASE_IMAGE=$BD/system-miku_treble_arm64_bgN.img
    mkdir --parents $BD/dsu/gapps/; mv $BASE_IMAGE $BD/dsu/gapps/system.img
    zip -j -v $BD/MikuUI-$VERSION-arm64-ab-gapps-$BUILD_DATE-UNOFFICIAL.zip $BD/dsu/gapps/system.img
    mkdir --parents $BD/dsu/gapps-vndklite/; mv ${BASE_IMAGE%.img}-vndklite.img $BD/dsu/gapps-vndklite/system.img
    zip -j -v $BD/MikuUI-$VERSION-arm64-ab-gapps-vndklite-$BUILD_DATE-UNOFFICIAL.zip $BD/dsu/gapps-vndklite/system.img
    rm -rf $BD/dsu
}

generateOtaJson() {
    echo ""
    echo "--> Generating Update json"
    echo ""
    prefix="MikuUI-$VERSION-"
    suffix="-$BUILD_DATE-UNOFFICIAL.zip"
    json="{\"version\": \"$VERSION\",\"date\": \"$(date +%s -d '-4hours')\",\"variants\": ["
    find $BD -name "*.zip" | {
        while read file; do
            packageVariant=$(echo $(basename $file) | sed -e s/^$prefix// -e s/$suffix$//)
            case $packageVariant in
                "arm64-ab") name="miku_treble_arm64_bvN";;
                "arm64-ab-vndklite") name="miku_treble_arm64_bvN-vndklite";;
                "arm64-ab-gapps") name="miku_treble_arm64_bgN";;
                "arm64-ab-gapps-vndklite") name="miku_treble_arm64_bgN-vndklite";;
            esac
            size=$(wc -c $file | awk '{print $1}')
            url="https://github.com/xiaoleGun/treble_build_miku/releases/download/$VERSION/$(basename $file)"
            json="${json} {\"name\": \"$name\",\"size\": \"$size\",\"url\": \"$url\"},"
        done
        json="${json%?}]}"
        echo "$json" | jq . > $BL/ota.json
        cp $BL/ota.json $BD/ota.json
    }
}

personal() {
  echo ""
  echo "--> Pack all for me"
  echo ""
  7z a -t7z -r $BD/all.7z $BD/*
  rm -rf $BD/*.zip $BD/ota.json
}

START=`date +%s`
BUILD_DATE="$(date +%Y%m%d)"

initrepo
syncrepo
applyingpatches
initenvironment
buildTrebleApp
buildtreble
buildSasImages
generatePackages
generateOtaJson
if [ $USER == xiaolegun ];then
personal
fi

END=`date +%s`
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo ""
echo "--> Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo ""
