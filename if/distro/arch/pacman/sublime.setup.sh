#!/bin/bash

# Check pacman installed
hash pacman 2>/dev/null || return

key="8A8F901A"

if pacman-key --list-keys $key > /dev/null 2>&1 ; then
	info "sublime key already installed"
else
	info "installing sublime key"
	info "root necessary to install sublime key"
	fifo="$(mktemp -ut sublime.XXXXXX.gpg)"
	mkfifo $fifo
	if curl -skL https://download.sublimetext.com/sublimehq-pub.gpg > $fifo & sudo pacman-key --add $fifo 2>&1 | while read line ; do debug "$line" ; done ; then
		success "added sublime key"
	else
		warn "sublime key installation failed"
		return
	fi
	if sudo pacman-key --lsign-key $key 2>&1 | while read line ; do debug "$line" ; done ; then
		success "signed sublime key"
	else
		warn "sublime key signing failed"
		sudo pacman-key --delete $key 2>&1 | while read line ; do debug "$line" ; done
		return
	fi
	rm -rf $fifo
fi

channel="https://download.sublimetext.com/arch/stable/x86_64"
if grep -Fq "$channel" /etc/pacman.conf ; then
	info "sublime channel already set up"
else
	info "setting up sublime channel"
	info "root necessary to set up sublime channel"
	echo -e "\n[sublime-text]\nServer = $channel" | sudo tee -a /etc/pacman.conf > /dev/null
	success "sublime channel set up"
fi
