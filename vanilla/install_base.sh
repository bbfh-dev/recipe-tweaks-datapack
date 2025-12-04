#!/bin/sh

tmp_dir=$(mktemp -d)
version=$1

if [ -z $version ]; then
	echo "Usage: ./new.sh <version>"
	exit 1
fi

git clone \
	https://github.com/misode/mcmeta.git \
	--depth 1 \
	--branch "${version}-data" \
	$tmp_dir

pack_format=$(cat $tmp_dir/version.json | jq .data_pack_version)
padded_pack_format=$(printf "%03d" $pack_format)
dir=./${padded_pack_format}_base_${version//\./-}
mkdir $dir

for file in $tmp_dir/data/minecraft/recipe/*; do
	basename=$(basename $file)
	cat $file | jq -M --tab . >$dir/$basename
done

ln -s $dir ./000_base
echo "==> Done."
