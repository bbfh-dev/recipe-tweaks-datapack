#!/bin/sh

ansi_green="\e[32m"
ansi_blue="\e[34m"
ansi_reset="\e[0m"

log() {
	printf " %b->%b %s\n" $ansi_blue $ansi_reset "$*"
}

log_call() {
	printf " %b->%b %s... " $ansi_blue $ansi_reset "$*"
}

section() {
	printf "%b==>%b %s\n" $ansi_green $ansi_reset "$*"
}

PATCHES=""
if [ $# -eq 0 ]; then
	PATCHES=$(ls -A ./patches)
else
	PATCHES="$*"
fi

# ————————————————

section "Setting up..."
BUILD_DIR=../build

log "Cleaning $BUILD_DIR directory"
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

log "Copying pack.mcmeta -> $BUILD_DIR/."
cp ./pack.mcmeta $BUILD_DIR/.

# ————————————————

section "Generating base version (from $(readlink ../vanilla/000_base))"
mkdir -p $BUILD_DIR/data/minecraft/recipe

build() {
	in_dir=$1
	out_dir=$2

	for patch in $PATCHES; do
		first_line=$(head -n 1 ./patches/$patch)
		pattern=${first_line#"# PATTERN: "}

		if [ -z $pattern ]; then
			log "ERROR: Unknown pattern in '$patch'"
		else
			for file in $in_dir/${pattern}.json; do
				if [ -f $file ]; then
					basename=$(basename $file)
					log_call " COPY $basename"
					cat $file | ./patches/$patch "$basename" "$out_dir/$basename"
				fi
			done

			for file in $in_dir/${pattern}.json.patch; do
				if [ -f $file ]; then
					basename=$(basename $file)
					basename="${basename%.patch}"
					patch -s \
						-o /tmp/patched-file.json \
						$(realpath ../vanilla/000_base/$basename) \
						$file
					log_call "PATCH($patch) $basename"
					cat /tmp/patched-file.json | ./patches/$patch "$basename" "$out_dir/$basename"
				fi
			done
		fi
	done
}

build ../vanilla/000_base $BUILD_DIR/data/minecraft/recipe

# ————————————————

already_patched=$(readlink ../vanilla/000_base)
already_patched=${already_patched#./}
for directory in ../vanilla/0*_*; do
	if [ $directory != *"$already_patched" ] && [ ! -L $directory ]; then
		basename=$(basename $directory)
		section "Generating overlay (from $basename)"
		prefix=$(echo "$basename" | cut -c1-3)
		cleaned="${prefix##0}"

		out_dir=../build/overlay_v$cleaned/data/minecraft/recipe
		mkdir -p $out_dir
		build $directory $out_dir
	fi
done
