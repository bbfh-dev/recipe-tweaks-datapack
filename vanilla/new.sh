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
dir=./${padded_pack_format}_patched_${version//\./-}
mkdir $dir

for file in ./000_base/*.json; do
	basename=$(basename $file)
	target=$tmp_dir/data/minecraft/recipe/$basename

	if [ -f $target ]; then
		cp $target /tmp/original-file
		cat /tmp/original-file | jq -M --tab . >$target

		patch_file=$dir/${basename}.patch

		diff -u $file $target >$patch_file
		if [ -s $patch_file ]; then
			printf " -> PATCHED: %s\n" $basename
		else
			rm $patch_file
		fi
		rm $target
	else
		touch $dir/${basename}.removed
		printf " -> REMOVED: %s\n" $basename
	fi
done

# All remaining files are new
for file in $tmp_dir/data/minecraft/recipe/*.json; do
	if [ -f $file ]; then
		basename=$(basename $file)
		cat $file | jq -M --tab . >$dir/${basename}
		printf " ->   ADDED: %s\n" $basename
	fi
done

echo "==> Done."
