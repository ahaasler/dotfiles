#!/bin/bash

# Check npm installed
hash npm 2>/dev/null || return 0

info 'installing common node modules'
if ( cat "$DOTFILES_HOME/node/software.txt" | xargs npm install -g ) 2>&1 | while read line
	do
		debug "$line";
	done
then
	success "installed node modules"
else
	warn "node modules installation failed"
fi
