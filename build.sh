if [[ -z $1 ]]; then
	rm -rf ./build
	mkdir ./build
	cp ./pack.mcmeta ./build/.
	find \
		./data/ \
		-type f \
		-exec ./build.sh {} \;
	exit
fi

COLORS=(
	black
	blue
	brown
	cyan
	gray
	green
	light_blue
	light_gray
	lime
	magenta
	orange
	pink
	purple
	red
	white
	yellow
)

WOODS=(
	acacia
	bamboo
	birch
	cherry
	crimson
	dark_oak
	jungle
	mangrove
	oak
	spruce
	warped
)

file=$1
dest=${file/data/'build/data'}
overlay_dest=${file/data/'build/overlay_61/data'}
mkdir -p $(dirname $overlay_dest)

if [[ $file == *"[color]"* ]]; then
	mkdir -p $(dirname $dest)
	for color in ${COLORS[@]}; do
		local_dest=${dest/\[color\]/$color}
		local_overlay_dest=${overlay_dest/\[color\]/$color}
		sed "s/\[color\]/$color/g" $file >$local_dest
		echo " -> $local_dest"
		./override_v61/per_file.sh $local_dest >$local_overlay_dest
	done
fi

if [[ $file == *"[wood]"* ]]; then
	mkdir -p $(dirname $dest)
	for wood in ${WOODS[@]}; do
		local_dest=${dest/\[wood\]/$wood}
		local_overlay_dest=${overlay_dest/\[wood\]/$wood}
		sed "s/\[wood\]/$wood/g" $file >$local_dest
		echo " -> $local_dest"
		./override_v61/per_file.sh $local_dest >$local_overlay_dest
	done
fi
