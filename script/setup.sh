#!/bin/bash

set -e

if [ -z "$DOTFILES_HOME" ]; then
	DOTFILES_HOME="$HOME/.dotfiles"
fi

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

# Author: Zach Holman <zach@zachholman.com>
# License: MIT (licenses/holman-dotfiles.md)
link_file () {
	local src=$1 dst=$2

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
			rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" == "true" ]
		then
			mv "$dst" "${dst}.backup"
			success "moved $dst to ${dst}.backup"
		fi

		if [ "$skip" == "true" ]
		then
			success "skipped $src"
		fi
	fi

	if [ "$skip" != "true" ]	# "false" or empty
	then
		ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

# Author: Zach Holman <zach@zachholman.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Use empty file ended in .symlink to copy file with same name but without that ending
# - Don't add dot by default in dst filename
# - Make .git restriction in find command more precise (only .git folder)
# License: MIT (licenses/holman-dotfiles.md) and MIT (LICENSE) for modifications
install_dotfiles () {
	info 'installing dotfiles'
	local overwrite_all=false backup_all=false skip_all=false
	for file in $(find -H "$DOTFILES_HOME" -maxdepth 2 -name '*.symlink' -not -path '*/.git.symlink' -not -path '*/.git/**')
	do
		src="${file%.*}"
		dst="$HOME/$(basename "$src")"
		link_file "$src" "$dst"
	done
}

if [ ! -d "$DOTFILES_HOME" ]; then
	fail "$DOTFILES_HOME doesn't exist"
fi

install_dotfiles
