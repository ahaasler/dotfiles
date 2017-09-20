#!/bin/bash

# Based on the gist https://gist.github.com/colinstein/de1755d2d7fbe27a0f1e

dotfiles_encrypt() {
	local file="$1"
	local pass="$(openssl rand 200)"
	openssl aes-256-cbc -in $file -out $file.enc -pass pass:"$pass"
	echo "$pass" | openssl rsautl -encrypt -pubin -inkey <(ssh-keygen -e -f ~/.ssh/id_rsa.pub -m PKCS8) -out $file.key
}

dotfiles_decrypt() {
	local file=$(echo "$1" | sed 's/\.enc//g')
	local pass="$(openssl rsautl -decrypt -ssl -inkey ~/.ssh/id_rsa -in $file.key)"
	openssl aes-256-cbc -d -in $file.enc -out $file.dec -pass pass:"$pass"
}
