#!/usr/bin/env bash

file="$HOME/.local/share/clipman.json"

# Exit if history does not exist
[ -f "$file" ] || exit

size="$(jq '. | length' $file)"

# Exit if history is 1 or less
[ "$size" -gt "1" ] || exit

# Get current time in millis
now=$(date +%s%N | cut -b1-13)

# Default lasts
last_index='0'
last_time=$now

# Source last
last="$HOME/.local/share/clipboard-rotate-last.sh"
[ -f "$last" ] && source $last

# Defaults
mode='previous'
timeout=1500

# Get configuration
while getopts ":npt:" opt; do
	case $opt in
		n) mode='next' ;;
		p) mode='previous' ;;
		t) timeout=$OPTARG ;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

# Default index is 1, add 1 to previous if same mode before timeout is done
index=1
if [[ "$now - $last_time" -le $timeout ]]; then
	if [ "$last_mode" == "$mode" ]; then
		index=$(( $last_index + 1 ))
	fi
fi

# Save used configuration for next execution
echo "last_index=$index" > $last
echo "last_mode=$mode" >> $last
echo "last_time=$now" >> $last

# Print desired clipboard item
jq -r ".[$(( $size - 1 - ($index % $size) ))]" $file
