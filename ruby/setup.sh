#!/bin/bash

# Check gem installed
hash gem 2>/dev/null || return 0

info 'installing common ruby gems'
if ( cat "$DOTFILES_HOME/ruby/software.txt" | xargs gem install --user-install ) 2>&1 | while read line
	do
		debug "$line";
	done
then
	success "installed ruby gems"
else
	warn "ruby gems installation failed"
fi