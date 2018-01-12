#!/bin/bash

# Refresh fonts
if hash fc-cache 2>/dev/null; then
	info "refreshing fonts"
	if fc-cache -f -v 2>&1 | while read line; do debug "$line"; done ; then
		success "generated font cache"
	else
		warn "font generation failed"
	fi
else
	info "skipped font refresh because fc-cache is not installed"
fi
