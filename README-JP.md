# Miku UI GSI

## はじめに
これは初音ミクのファンのための Android プロジェクトです。もし気に入らないのであればこのページを閉じてください。ただし、ミクやこのプロジェクトの作者を責める行動はしないでください。

## バリアント
一例
> MikuUI-TDA-0.13.3-arm64-ab-vndklite-gapps-20230406-UNOFFICIAL.img.xz

これらは
```
ProjectName-{SNOW | SNOWLAND | TDA}-Miku UI version-arm64-ab-vndklite-gapps-BuildDate-Buildtype
 |                |          |                        |    |     |      |
 |                |          |                        |    |     |      |
 |                |          |                        |    |     |     GMS
 |                |          |                        |    |     |
 |                |          |                        |    |     |
 |                |          |                        |    |    vndkliteが使用されています。 
 |                |          |                        |    |    システムの読み書きが可能になっています。
 |                |          |                        |    |
 |                |          |                        |  パーティションタイプ、これはA/Bパーティションに対応しています。(1)
 |                |          |                        |
 |                |          |                        |
 |                |          |                   CPU のビット数、これは64ビットになります。a64と書かれてもいます。(2)
 |                |          |
 |     Android 12 | 12.1     | 13  
 |
Miku UI
```

(1) Android 9 以降の Vendor は SAR (system-as-root) をサポートしているので、A/B パーティションタイプの GSI が使用できます。

(2) arm32 binder64

## ビルド
Miku UI GSI のビルドを始めるには、[How to build a GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F) と同様に、[Git と Repo](https://source.android.com/source/using-repo.html) の操作を覚える必要があります。
- 依存関係のインストールをする
    ```
    sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev xattr openjdk-11-jdk jq android-sdk-libsparse-utils python3 python2 repo
    ```
- Miku UI ビルド用の作業ディレクトリを作成して移動する:
    ```
    mkdir miku-treble && cd miku-treble
    ```
- このリポジトリをクローンする:
    ```
    git clone https://github.com/xiaoleGun/treble_build_miku -b Udon
    ```
- 最後にビルドスクリプトを実行する:
    ```
    bash treble_build_miku/build.sh
    ```

## クレジット
このプロジェクトに協力してくれた方々になります。様々な事しているので何らかの形で評価をして欲しいと思います:
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
