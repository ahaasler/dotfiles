#!/usr/bin/env bash

if hash notify-send.sh 2>/dev/null; then
	previousFile=~/.local/share/clipboard-notify-last.txt
	previousId="$(tr -d '\n' < $previousFile)"
	if ! [[ "$previousId" =~ ^[0-9]+$ ]]; then
		notify-send.sh 'Copied to clipboard' "${1}" --icon=edit-paste -t 3000 -a 'sway' -p > "$previousFile"
	else
		notify-send.sh 'Copied to clipboard' "${1}" --icon=edit-paste -t 3000 -a 'sway' -r $previousId -p > "$previousFile"
	fi
elif hash notify-send 2>/dev/null; then
	notify-send 'Copied to clipboard' "${1}" --icon=edit-paste -t 2000 -a 'sway'
fi
