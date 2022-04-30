# Miku UI GSI

## Preface
This is an Android project for Miku fans. If you don't like it, please close this page, but don't attack Miku and the author of this project.

## Build
To get started with building Miku UI GSI, you'll need to get familiar with [Git and Repo](https://source.android.com/source/using-repo.html) as well as [How to build a GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F).
- Install dependencies
    ```
    sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev xattr openjdk-11-jdk jq android-sdk-libsparse-utils
    ```
- Create a new working directory for your Miku UI build and navigate to it:
    ```
    mkdir miku-treble && cd miku-treble
    ```
- Clone this repo:
    ```
    git clone https://github.com/xiaoleGun/treble_build_miku -b snowland
    ```
- Finally, start the build script:
    ```
    bash treble_build_miku/build.sh
    ```

## Credits
These people have helped this project in some way or another, so they should be the ones who receive all the credit:
- [Miku-UI](https://github.com/Miku-UI)
- [Project-Mushroom](https://github.com/Project-Mushroom)
- [phhusson](https://github.com/phhusson)
- [AndyCGYan](https://github.com/AndyCGYan)
- [ponces](https://github.com/ponces)
- [Yilliee](https://github.com/Yilliee)
