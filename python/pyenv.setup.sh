#!/bin/bash
if [ ! -h "$HOME/.pyenv/bin" ]; then
	info 'creating pyenv folder'
	if ( mkdir -p "$HOME/.pyenv" ) 2>&1 | while read line
		do
			debug "$line";
		done
	then
		success "created pyenv folder"
	else
		warn "pyenv folder creation failed"
	fi
	info 'linking pyenv files'
	mkdir -p "$HOME/.pyenv/plugins"
	ln -sfn "$DOTFILES_HOME/python/pyenv/bin" "$HOME/.pyenv/"
	ln -sfn "$DOTFILES_HOME/python/pyenv/libexec" "$HOME/.pyenv/"
	ln -sfn "$DOTFILES_HOME/python/pyenv/plugins/python-build" "$HOME/.pyenv/plugins/"
fi
