#!/bin/bash

set -e
set -o pipefail

args="$@"

# -h option is discarded because dotfiles are already downloaded.
# This avoid user error if this script is called directly
home="$(cd "$( dirname $(dirname "$BASH_SOURCE" ))" && pwd)"

# Create local configuration and read it
source $home/script/local/create.sh
source $HOME/.dotfiles.local

# Setup
$home/script/setup.sh "$args"
