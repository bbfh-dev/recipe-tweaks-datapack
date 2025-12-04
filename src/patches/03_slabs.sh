# PATTERN: *_slab
jq -M --tab '.pattern |= ["##"] | .result.count |= 4' >"$2"
printf "Done.\n"
