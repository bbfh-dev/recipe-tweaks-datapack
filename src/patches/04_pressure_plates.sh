# PATTERN: *_pressure_plate
jq -M --tab '.pattern |= ["###"] | .result.count |= 12' >"$2"
printf "Done.\n"
