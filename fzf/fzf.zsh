#!/bin/zsh

# Completion
if [[ -r /usr/share/fzf/completion.zsh ]]; then
	source /usr/share/fzf/completion.zsh
fi

# Key bindings
if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
	source /usr/share/fzf/key-bindings.zsh
fi
