# Miku UI GSI

## Preface
This is an Android project for Miku fans. If you don't like it, please close this page, but don't attack Miku and the author of this project.

## Version
Latest version: 0.17.2

[Downloads](https://github.com/xiaoleGun/treble_build_miku/releases)

## Variant
Examples
> MikuUI-TDA-0.13.3-arm64-ab-vndklite-gapps-20230406-UNOFFICIAL.img.xz

They are
```
ProjectName-{SNOW | SNOWLAND | TDA}-Miku UI version-arm64-ab-vndklite-gapps-BuildDate-Buildtype
 |                |          |                        |    |     |      |
 |                |          |                        |    |     |      |
 |                |          |                        |    |     |     GMS
 |                |          |                        |    |     |
 |                |          |                        |    |     |
 |                |          |                        |    |    It is used for vndklite devices and 
 |                |          |                        |    |    supports system reading and writing.
 |                |          |                        |    |
 |                |          |                        |  Partition type, only AB variants are provided.(1)
 |                |          |                        |
 |                |          |                        |
 |                |          |                   CPU bits, build 64 bits and a64(2).
 |                |          |
 |     Android 12 | 12.1     | 13  
 |
Miku UI
```

(1) Vendors of Android 9 and above support SAR(system-as-root), so GSI of AB partition type can be used.

(2) arm32 binder64

## Build
To get started with building Miku UI GSI, you'll need to get familiar with [Git and Repo](https://source.android.com/source/using-repo.html) as well as [How to build a GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F).
- Install dependencies
    ```
    sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev xattr openjdk-11-jdk jq android-sdk-libsparse-utils python3 python
    ```
- Create a new working directory for your Miku UI build and navigate to it:
    ```
    mkdir miku-treble && cd miku-treble
    ```
- Clone this repo:
    ```
    git clone https://github.com/xiaoleGun/treble_build_miku -b TDA
    ```
- Finally, start the build script:
    ```
    bash treble_build_miku/build.sh
    ```

## Credits
These people have helped this project in some way or another, so they should be the ones who receive all the credit:
- [Miku-UI](https://github.com/Miku-UI)
- [phhusson](https://github.com/phhusson)
- [AndyCGYan](https://github.com/AndyCGYan)
- [ponces](https://github.com/ponces)
- [eremitein](https://github.com/eremitein)
- [kdrag0n](https://github.com/kdrag0n)
- [Peter Cai](https://github.com/PeterCxy)
- [haridhayal11](https://github.com/haridhayal11)
- [sooti](https://github.com/sooti)
- [Iceows](https://github.com/Iceows)