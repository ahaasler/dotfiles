#!/bin/bash

install_packages() {
	local folder="$DOTFILES_HOME/$2"
	local pattern="$1"
	local blacklist="$3"
	for file in $(find -H "$folder" -maxdepth 3 -name "$pattern" -not -path '*/.git/**' -not -path "$folder/if/**" -not -path "$blacklist")
	do
		package=$(basename $(dirname $file))
		info "installing $package"
		folder="$(mktemp -ut dotfiles_install_XXXXXX)"
		mkdir $folder
		cp -r $(dirname $file)/. $folder
		pushd $folder > /dev/null
		if makepkg -s 2>&1 | while read line; do debug "$line"; done ; then
			success "built $package"
		else
			warn "$package building failed"
		fi
		if sudo pacman -U --noconfirm *xz 2>&1 | while read line; do debug "$line"; done ; then
			success "installed $package"
		else
			warn "$package installation failed"
		fi
		popd > /dev/null
		rm -rf $folder
	done
}

info "installing dummy packages"
info "root necessary to install dummy packages"
install_packages 'PKGBUILD' "if/distro/arch/pacman/dummy"
