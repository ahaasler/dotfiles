#!/bin/bash

# Based on the gist https://gist.github.com/colinstein/de1755d2d7fbe27a0f1e

dotfiles_encrypt() {
	local file="$1"
	local target="$2/$(basename "$1")"
	if [ -z "$2" ]; then
		target="$1"
	fi
	mkdir -p $(dirname $target)
	local pass="$(openssl rand -base64 170)"
	openssl aes-256-cbc -in $file -out $target.enc -pass pass:"$pass"
	echo "$pass" | openssl rsautl -encrypt -pubin -inkey <(ssh-keygen -e -f ~/.ssh/id_rsa.pub -m PKCS8) -out $target.key
}

dotfiles_decrypt() {
	local file=$(echo "$1" | sed 's/\.enc//g')
	local pass="$(openssl rsautl -decrypt -ssl -inkey ~/.ssh/id_rsa -in $file.key)"
	openssl aes-256-cbc -d -in $file.enc -out $file.dec -pass pass:"$pass"
}
