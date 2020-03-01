#!/usr/bin/env bash

text=$(cat)
echo "$text" | clipman store
~/.config/sway/scripts/clipboard-notify.sh "$text"
