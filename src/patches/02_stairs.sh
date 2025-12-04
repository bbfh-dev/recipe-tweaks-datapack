# PATTERN: *_stairs
out=$(echo "$2" | sed 's/minecraft/recipe_tweaks/')
mkdir -p $(dirname $out)

tmp=$(mktemp)
tee $tmp | jq -M --tab '.result.count |= 8' >"$2"
jq -M --tab '.pattern |= .[:-1]' $tmp >"$out"
rm -f $tmp

printf "Done.\n"
