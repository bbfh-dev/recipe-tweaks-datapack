# PATTERN: *_door
jq -M --tab '.result.count |= 6' >"$2"
printf "Done.\n"
