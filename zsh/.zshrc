#!/bin/zsh

# Start tmux if conditions are met
emulate sh
source $DOTFILES_HOME/tmux/start.sh
emulate zsh

# Powerline
if [[ -r $DOTFILES_HOME/shell/powerline/powerline/bindings/zsh/powerline.zsh ]]; then
	source $DOTFILES_HOME/shell/powerline/powerline/bindings/zsh/powerline.zsh
fi

# Key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OC" forward-word
bindkey "^[OD" backward-word
bindkey "^[[3~" delete-char

# Enable completion
autoload -U compinit
compinit

# History
export HISTSIZE=20000
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=$HISTSIZE

setopt ALL_EXPORT
setopt HIST_IGNORE_DUPS
# Report the status of background jobs immediately
setopt NOTIFY
# Lets files beginning with a . be matched without explicitly specifying the dot
setopt GLOB_DOTS
# Turns on spelling correction for commands and for all arguments
setopt CORRECT_ALL
# Don't close background jobs on exit
setopt NO_HUP
# Save each command’s beginning timestamp and the duration
setopt EXTENDED_HISTORY
# On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately.
setopt MENU_COMPLETE

fpath=($DOTFILES_HOME/zsh/zsh-completions/src $fpath)
source $DOTFILES_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $DOTFILES_HOME/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source_dotfiles_pattern '*.zsh'
# Source distro specific zsh config
if [ "$DISTRO" ] && [ -d "$DOTFILES_HOME/if/distro/$DISTRO" ]; then
	source_dotfiles_pattern '*.zsh' "if/distro/$DISTRO/"
fi
# Source distro specific zsh config
if [ "$(hostname)" ] && [ -d "$DOTFILES_HOME/if/hostname/$(hostname)" ]; then
	source_dotfiles_pattern '*.zsh' "if/hostname/$(hostname)/"
fi
