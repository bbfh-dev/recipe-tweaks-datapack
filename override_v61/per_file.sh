jq '.key |= with_entries(.value = .value.item)' $1
