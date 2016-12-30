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
# License: MIT (licenses/holman-dotfiles.md)
link_file () {
	local src=$1 dst=$2 prepend=$3

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
	then

		if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
		then

			local currentSrc="$(readlink $dst)"

			if [ "$currentSrc" == "$src" ]
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
		mkdir -p $(dirname $dst)
		link_file "$src" "$dst"
	done

	for file in $(find -H "$base_folder" -maxdepth 3 -name '*.rootlink' -not -path '*/.git.rootlink' -not -path '*/.git/**' -not -path "$base_folder/if/**")
	do
		src="${file%.*}"
		dst="$(expandPath $(head -n 1 $file))"
		mkdir -p $(dirname $dst)
		info "root necessary to setup $dst"
		link_file "$src" "$dst" "sudo"
	done
}

install_powerline() {
	info 'installing powerline'
	if ( cd $DOTFILES_HOME/shell/powerline && python setup.py install --user ) 2>&1 | while read line
			do
				debug "$line";
				if [ "$line" == "Compiling C version of powerline-client failed" ]; then
					warn "installing powerline's python command (slow), install gcc and setup again for faster prompt"
				fi
			done
	then
		success "installed powerline"
	else
		warn "powerline installation failed"
	fi
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

install_dotfiles $DOTFILES_HOME
install_powerline

# Refresh fonts
if hash fc-cache 2>/dev/null; then
	info "refreshing fonts"
	if fc-cache -f -v 2>&1 | while read line; do debug "$line"; done ; then
		success "generated font cache"
	else
		warn "font generation failed"
	fi
else
	info "skipped font refresh because fc-cache is not installed"
fi

# Warn about changes
warn "to see all changes logout and login again"
