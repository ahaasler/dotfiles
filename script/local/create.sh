#!/bin/bash

set -e
set -o pipefail

debug=false

# -h option is discarded because dotfiles are already downloaded.
# This avoid user error if this script is called directly
home="$(cd "$(dirname $(dirname $(dirname "$BASH_SOURCE" )))" && pwd)"

# Functions
source "$home/script/function/log.sh"

while getopts ":vdh:" opt; do
	case $opt in
		v|d) debug=true ;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

info "generating dotfiles local config"

# Get distro name
source $home/if/distro/export.sh

# Generate dotfiles local conf
debug "using home $home"
echo "export DOTFILES_HOME=$home" > ~/.dotfiles.local
debug "detected distro $DISTRO"
echo "export DISTRO=$DISTRO" >> ~/.dotfiles.local
