# Recipe Tweaks

Minecraft 1.21+ QoL data pack to selectively improve recipes

<!-- vim-markdown-toc GFM -->

* [Features](#features)
* [Download pre-built](#download-pre-built)
* [Building from source](#building-from-source)

<!-- vim-markdown-toc -->

## Features

> [!NOTE]
> By [building from source](#building-from-source) you are able to toggle them individually or add your own.

| Before | After |
| ------ | ----- |
| ![before](./.github/images/01_carpets-before.png) | ![after](./.github/images/01_carpets-after.png) |
| ![before](./.github/images/02_stairs-before.png) | ![after](./.github/images/02_stairs-after-1.png) |
| | ![after](./.github/images/02_stairs-after-2.png) |
| ![before](./.github/images/03_slabs-before.png) | ![after](./.github/images/03_slabs-after.png) |
| ![before](./.github/images/04_pressure_plate-before.png) | ![after](./.github/images/04_pressure_plate-after.png) |
| ![before](./.github/images/05_doors-before.png) | ![after](./.github/images/05_doors-after.png) |
| ![before](./.github/images/06_trapdoors-before.png) | ![after](./.github/images/06_trapdoors-after.png) |

## Download pre-built

Navigate to [latest release](https://github.com/bbfh-dev/recipe-tweaks-datapack/releases/latest) and download the needed version.

## Building from source

> [!IMPORTANT]
> Requires `jq` and coreutils to be installed.

With all patches from `./src/patches/`:

```bash
cd ./src
./build.sh
```

If you want to build using only specific patches:

```bash
cd ./src
./build.sh 01_carpets.sh 06_trapdoors.sh # etc.
```
