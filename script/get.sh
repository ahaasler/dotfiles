#!/bin/bash

set -e
set -o pipefail

if [ -z "$DOTFILES_HOME" ]; then
	DOTFILES_HOME="$HOME/.dotfiles"
fi

mkdir -p $DOTFILES_HOME

echo "installing dotfiles in $DOTFILES_HOME"

hash curl 2>/dev/null || { echo >&2 "curl is not installed, please install it"; exit 1; }

releaseUrl=$(curl -s https://api.github.com/repos/ahaasler/dotfiles/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
echo "downloading latest release: $releaseUrl"
curl -skL $releaseUrl | tar zx --strip-components 1 -C $DOTFILES_HOME

$DOTFILES_HOME/script/setup.sh
