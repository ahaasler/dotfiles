#!/bin/bash

source_dotfiles_pattern() {
	hash find 2>/dev/null || return 1
	local folder="$DOTFILES_HOME/$2"
	local pattern="$1"
	local blacklist="$3"
	for file in $(find -H "$folder" -maxdepth 3 -name "$pattern" -not -path '*/.git/**' -not -path "$folder/if/**" -not -path "$blacklist")
	do
		source $file
	done
}
