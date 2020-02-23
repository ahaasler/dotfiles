#!/usr/bin/env bash

# Author: xPMo & Adrian Haasler <dev@adrianhaasler.com>
# Based on grim-wrapper.sh by xPMo (https://gitlab.com/gamma-neodots/neodots.guibin/-/blob/master/grim-wrapper.sh)
# This script is inspired and was started based on the one from xPMo, but with modifications to my liking.
# License: MIT (licenses/gamma-neodots-guibin) and MIT (LICENSE)

IFS=$'\n'

usage() {
	cat >&2 << EOF
$(basename "$0") [ -w | -s | -d ] [ FILE ]

Take a screenshot

	-w    screenshot current active window
	-s    screenshot selection
	-d    screenshot display (default)
	-m    screenshot menu
	-h    show this help
	FILE  destination for screenshot

The last provided flag before [ FILE ] will be used,
or display by default.
EOF
}

menu() {
	options=( '1: display' '2: selection' '3: window' )

	select_option() {
		case $1 in
			'1: display' ) echo 'd' ;;
			'2: selection' ) echo 's' ;;
			'3: window' ) echo 'w' ;;
		esac
	}

	# starting wofi in dmenu mode
	select_option "$(printf "%s\n" "${options[@]}" | wofi --dmenu -i --sort-order alphabetical -p 'Select screenshot mode')"
}

# === ENVIRONMENT VARIABLES ===
ssdir=${SCREENSHOT_DIRECTORY:-$HOME/Pictures/Screenshots}

# === GETOPTS ===
# if no opt provided, don't shift
mode=d
while getopts ":dhswm" o; do
	case "$o" in
	[dsw]) mode="$o" ;;
	m ) mode="$(menu)" ;;
	h ) usage && exit 0 ;;
	* ) usage && exit 1 ;;
	esac
done
shift $(( OPTIND - 1 ))

# === IMAGE LOCATION ===
if (( $# )); then
	# create path if it doesn't exist
	mkdir -p "$(dirname "$1")"
	img="$1"
else
	mkdir -p "$ssdir"
	img=$(mktemp -u "${ssdir}/$(date +%Y-%m-%d_%T).XXX" --suffix=.png)
fi

# === TAKE SCREENSHOT ===
case $mode in # active window / selection / whole screen
	w)
		x="$(swaymsg -t get_tree | jq -r \
			'.nodes[].nodes[]|select(.name!="__i3_scratch")|
			.floating_nodes[],recurse(.nodes[])|select(.focused)|.rect|
			(.x|tostring)+","+(.y|tostring)+" "+(.width|tostring)+"x"+(.height|tostring)'
		)"
		grim -g "${x%%*$'\n'}" "$img"
	;;
	s) grim -g "$(slurp)" "$img" ;;
	d) grim "$img" ;;
esac
