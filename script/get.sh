#!/bin/bash

set -e
set -o pipefail

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

# Author: Zach Holman <zach@zachholman.com>
# License: MIT (licenses/holman-dotfiles.md)
success () {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
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

if [ -z "$DOTFILES_HOME" ]; then
	DOTFILES_HOME="$HOME/.dotfiles"
fi

mkdir -p $DOTFILES_HOME

info "installing dotfiles in $DOTFILES_HOME"

hash curl 2>/dev/null || { fail >&2 "curl is not installed, please install it"; }

releaseUrl=$(curl -s https://api.github.com/repos/ahaasler/dotfiles/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
info "downloading latest release: $releaseUrl"
curl -skL $releaseUrl | tar zx --strip-components 1 -C $DOTFILES_HOME

$DOTFILES_HOME/script/setup.sh
