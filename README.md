# Recipe Tweaks

Minecraft QoL data pack to selectively improve recipes

## Download pre-built

Navigate to [latest](https://github.com/bbfh-dev/recipe-tweaks-datapack/releases/latest) and download the needed version.

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
