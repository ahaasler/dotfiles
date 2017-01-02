#!/bin/bash

set -e
set -o pipefail

debug=false

# Source old configuration file to retrieve old values (for future use)
source ~/.dotfiles.local

# Obtain dotfiles dir ignoring old value
home="$(cd "$(dirname $(dirname $(dirname "$BASH_SOURCE" )))" && pwd)"

# Functions
source "$home/script/function/log.sh"

while getopts ":vdh:" opt; do
	case $opt in
		v|d) debug=true ;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

info "updating dotfiles local config"

# Get distro name ignoring old value
source $home/if/distro/export.sh

# Generate dotfiles local conf
debug "using home $home"
echo "export DOTFILES_HOME=$home" > ~/.dotfiles.local
debug "detected distro $DISTRO"
echo "export DISTRO=$DISTRO" >> ~/.dotfiles.local
