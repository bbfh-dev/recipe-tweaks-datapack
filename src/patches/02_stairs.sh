# PATTERN: *_stairs
out=${2/minecraft/recipe_tweaks}
mkdir -p $(dirname $out)

tee >(jq -M --tab ".result.count |= 8" >"$2") \
	>(jq -M --tab ".pattern |= .[:-1]" >"$out") \
	>/dev/null

printf "Done.\n"
