#!/bin/bash

if [ ! -d "$HOME/.virtualenvs" ]; then
	info 'creating virtualenv folder'
	if ( mkdir $HOME/.virtualenvs ) 2>&1 | while read line
		do
			debug "$line";
		done
	then
		success "created virtualenv folder"
	else
		warn "virtualenv folder creation failed"
	fi
fi
