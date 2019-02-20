#!/bin/bash

debug () {
	if $debug; then printf "\r  [\033[0;35mDEBG\033[0m] $1\n"; fi
}

# Author: Zach Holman <zach@zachholman.com>
# License: MIT (licenses/holman-dotfiles.md)
info () {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

# Author: Zach Holman <zach@zachholman.com>
# License: MIT (licenses/holman-dotfiles.md)
user () {
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

userline () {
	printf "\r  [ \033[0;33m??\033[0m ] $1"
}

# Author: Zach Holman <zach@zachholman.com>
# License: MIT (licenses/holman-dotfiles.md)
success () {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

warn () {
	printf "\r  [\033[0;33mWARN\033[0m] $1\n"
}

# Author: Zach Holman <zach@zachholman.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Exit with non zero status code
# License: MIT (licenses/holman-dotfiles.md) and MIT (LICENSE) for modifications
fail () {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit 1
}
