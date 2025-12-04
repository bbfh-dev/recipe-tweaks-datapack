# PATTERN: *_carpet
ansi_green="\e[32m"
ansi_yellow="\e[33m"
ansi_reset="\e[0m"

if [[ $1 == "dye_"* ]]; then
	printf "%bSkipped.%b\n" $ansi_yellow $ansi_reset
	exit
fi

jq -M --tab ".result.count |= 8" >"$2"
printf "%bDone.%b\n" $ansi_green $ansi_reset
