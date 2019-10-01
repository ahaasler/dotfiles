#!/bin/bash

# Completion
if [[ -r /usr/share/fzf/completion.bash ]]; then
	source /usr/share/fzf/completion.bash
fi

# Key bindings
if [[ -r /usr/share/fzf/key-bindings.bash ]]; then
	source /usr/share/fzf/key-bindings.bash
fi
