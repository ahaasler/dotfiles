#!/bin/bash

set -e
set -o pipefail

args="$@"

# Variables
debug=false
overwrite_all=false
backup_all=false
skip_all=false

if [ -z "$DOTFILES_HOME" ]; then
	DOTFILES_HOME="$HOME/.dotfiles"
fi

# Functions

source $DOTFILES_HOME/script/function/log.sh
source $DOTFILES_HOME/script/function/source.sh
source $DOTFILES_HOME/script/function/encryption.sh

decrypt_dotfiles() {
	base_folder=$1
	info "decrypting dotfiles in $base_folder"
	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.enc' -not -path '*/.git.enc' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		dotfiles_decrypt $file
		success "decrypted $file"
	done
}

# Author: Charles Duffy (http://stackoverflow.com/a/29310477)
# License: cc by-sa 3.0 (licenses/cc-by-sa-3.0.txt)
expandPath() {
	local path
	local -a pathElements resultPathElements
	IFS=':' read -r -a pathElements <<<"$1"
	: "${pathElements[@]}"
	for path in "${pathElements[@]}"; do
		: "$path"
		case $path in
			"~+"/*)
				path=$PWD/${path#"~+/"}
				;;
			"~-"/*)
				path=$OLDPWD/${path#"~-/"}
				;;
			"~"/*)
				path=$HOME/${path#"~/"}
				;;
			"~"*)
				username=${path%%/*}
				username=${username#"~"}
				IFS=: read _ _ _ _ _ homedir _ < <(getent passwd "$username")
				if [[ $path = */* ]]; then
					path=${homedir}/${path#*/}
				else
					path=$homedir
				fi
				;;
		esac
		resultPathElements+=( "$path" )
	done
	local result
	printf -v result '%s:' "${resultPathElements[@]}"
	printf '%s\n' "${result%:}"
}

# Author: Zach Holman <zach@zachholman.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Canonicalize readlink
# License: MIT (licenses/holman-dotfiles.md) and MIT (LICENSE) for modifications
link_file () {
	local src=$1 dst=$2 prepend=$3

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
	then

		if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
		then

			if [ "$(readlink $dst)" == "$src" ] || [ "$(readlink -f $dst)" == "$src" ]
			then

				skip=true;

			else

				user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
				[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -n 1 action

				case "$action" in
					o )
						overwrite=true;;
					O )
						overwrite_all=true;;
					b )
						backup=true;;
					B )
						backup_all=true;;
					s )
						skip=true;;
					S )
						skip_all=true;;
					* )
						;;
				esac

			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [ "$overwrite" == "true" ]
		then
			$prepend rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" == "true" ]
		then
			$prepend mv "$dst" "${dst}.backup"
			success "moved $dst to ${dst}.backup"
		fi

		if [ "$skip" == "true" ]
		then
			success "skipped $src"
		fi
	fi

	if [ "$skip" != "true" ]	# "false" or empty
	then
		$prepend ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

# Author: Zach Holman <zach@zachholman.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Use empty file ended in .symlink to copy file with same name but without that ending
# - Don't add dot by default in dst filename
# - Make .git restriction in find command more precise (only .git folder)
# - Move 'overwrite_all', 'backup_all' and 'skip_all' outside function
# - Use file ended in .customlink to copy file with same name (without that ending) to the location defined inside the link file)
# - Use file ended in .rootlink to copy as root the file with same name (without that ending) to the location defined inside the link file)
# - Exclude if folder
# - Make base folder for search customizable
# License: MIT (licenses/holman-dotfiles.md) and MIT (LICENSE) for modifications
install_dotfiles () {
	base_folder=$1
	info "installing dotfiles in $base_folder"
	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.symlink' -not -path '*/.git.symlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${file%.*}"
		dst="$HOME/$(basename "$src")"
		link_file "$src" "$dst"
	done

	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.customlink' -not -path '*/.git.customlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${file%.*}"
		dst="$(expandPath $(head -n 1 $file))"
		if [ ! -d "$(dirname $dst)" ]; then
			mkdir -p $(dirname $dst)
		fi
		link_file "$src" "$dst"
	done

	for folder in $(find -H "$base_folder" -maxdepth 3 -name '*.contentlink' -not -path '*/.git.contentlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${folder%.*}"
		dst="$(expandPath $(head -n 1 $folder))"
		if [ ! -d "$(dirname $dst)" ]; then
			mkdir -p $(dirname $dst)
		fi
		for file in $(ls -A1 $src)
		do
			link_file "$src/$file" "$dst/$file"
		done
	done

	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.binlink' -not -path '*/.git.binlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${file%.*}"
		dst="$HOME/.local/bin"
		if [ ! -d "$dst" ]; then
			mkdir -p $dst
		fi
		if [ -d "${src}" ] ; then
			for file in $(ls -A1 $src)
			do
				link_file "$src/$file" "$dst/$file"
			done
		else
			link_file "$src" "$dst/$(basename "$src")"
		fi
	done

	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.rootlink' -not -path '*/.git.rootlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${file%.*}"
		dst="$(expandPath $(head -n 1 $file))"
		info "root necessary to setup $dst"
		if [ ! -d "$(dirname $dst)" ]; then
			sudo mkdir -p $(dirname $dst)
		fi
		link_file "$src" "$dst" "sudo"
	done
}

# Execution
while getopts ":dvh:OBS" opt; do
	case $opt in
		v|d) debug=true ;;
		O)
			info "using non-interactive setup with 'Override all' option for existing files"
			overwrite_all=true
			;;
		B)
			info "using non-interactive setup with 'Backup all' option for existing files"
			backup_all=true
			;;
		S)
			info "using non-interactive setup with 'Skip all' option for existing files"
			skip_all=true
			;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

if [ ! -d "$DOTFILES_HOME" ]; then
	fail "$DOTFILES_HOME doesn't exist"
fi

# Create fixed location link for dotfiles home
ln -sfn $DOTFILES_HOME ~/.dotfiles.home

# Decrypt hostname specific dotfiles
if [ "$(hostname)" ] && [ -d "$DOTFILES_HOME/if/hostname/$(hostname)" ]; then
	decrypt_dotfiles "$DOTFILES_HOME/if/hostname/$(hostname)/"
fi

install_dotfiles $DOTFILES_HOME
# Install distro specific dotfiles
if [ "$DISTRO" ] && [ -d "$DOTFILES_HOME/if/distro/$DISTRO" ]; then
	install_dotfiles "$DOTFILES_HOME/if/distro/$DISTRO/"
fi
# Install hostname specific dotfiles
if [ "$(hostname)" ] && [ -d "$DOTFILES_HOME/if/hostname/$(hostname)" ]; then
	install_dotfiles "$DOTFILES_HOME/if/hostname/$(hostname)/"
fi

# Setup specific parts
source_dotfiles_pattern '*setup.sh' '' "$DOTFILES_HOME/script/setup.sh"
# Setup distro specific parts
if [ "$DISTRO" ] && [ -d "$DOTFILES_HOME/if/distro/$DISTRO" ]; then
	source_dotfiles_pattern '*setup.sh' "if/distro/$DISTRO/"
fi
# Setup hostname specific parts
if [ "$(hostname)" ] && [ -d "$DOTFILES_HOME/if/hostname/$(hostname)" ]; then
	source_dotfiles_pattern '*setup.sh' "if/hostname/$(hostname)/"
fi

# Warn about changes
warn "to see all changes logout and login again"
