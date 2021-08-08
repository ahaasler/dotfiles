#!/bin/bash

# Check go installed
hash go 2>/dev/null || return 0

info 'installing common go binaries'
if ( cat "$DOTFILES_HOME/go/software.txt" | xargs -I{} sh -c 'GOPATH="$HOME/go"; go install {};' xargs-sh {}) 2>&1 | while read line
	do
		debug "$line";
	done
then
	success "installed go binaries"
else
	warn "go binaries installation failed"
fi
