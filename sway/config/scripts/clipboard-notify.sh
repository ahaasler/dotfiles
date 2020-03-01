#!/usr/bin/env bash

if hash notify-send.sh 2>/dev/null; then
	notify-send.sh 'Copied to clipboard' "${1}" --icon=edit-paste -t 3000 -a 'sway' -r $(cat ~/.local/share/clipboard-notify-last.txt) -p > ~/.local/share/clipboard-notify-last.txt
elif hash notify-send 2>/dev/null; then
	notify-send 'Copied to clipboard' "${1}" --icon=edit-paste -t 2000 -a 'sway'
fi
