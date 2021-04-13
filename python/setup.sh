#!/bin/bash

# Check pip installed
hash pip 2>/dev/null || return 0

info 'installing common python modules'
if ( pip install --upgrade --user -r "$DOTFILES_HOME/python/software.txt" ) 2>&1 | while read line
	do
		debug "$line";
	done
then
	success "installed python modules"
else
	warn "python modules installation failed"
fi
