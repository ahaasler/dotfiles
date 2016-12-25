#!/bin/bash

set -e
set -o pipefail

args="$@"

# Variables

debug=false
git=false

# Functions
source <(curl -skL https://raw.githubusercontent.com/ahaasler/dotfiles/master/script/function/log.sh)

home="$HOME/.dotfiles"

while getopts ":vdgh:" opt; do
	case $opt in
		v|d) debug=true ;;
		g) git=true ;;
		h) home=$OPTARG	;;
		\?) warn "unknown option: -$OPTARG" ;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

mkdir -p $home

info "installing dotfiles in $home"

if $git; then
	hash git 2>/dev/null || { fail >&2 "git is not installed, please install it"; }
	info "installing with git"
	rm -rf $home
	git clone --recursive https://github.com/ahaasler/dotfiles.git $home &>/dev/null
else
	hash curl 2>/dev/null || { fail >&2 "curl is not installed, please install it"; }
	info "intalling with curl"
	releaseUrl=$(curl -s https://api.github.com/repos/ahaasler/dotfiles/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
	info "downloading latest release: $releaseUrl"
	curl -skL $releaseUrl | tar zx --strip-components 1 -C $home
fi

success "downloaded dotfiles"

$home/script/install.sh $args
