#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Start tmux if conditions are met
source $DOTFILES_HOME/tmux/start.sh

# Use leftonly theme for powerline
export POWERLINE_CONFIG_OVERRIDES=ext.shell.theme=default_leftonly

PS1='[\u@\h \W]\$ '

# Powerline
if [ -f $DOTFILES_HOME/shell/powerline/powerline/bindings/bash/powerline.sh ]; then
	source $DOTFILES_HOME/shell/powerline/powerline/bindings/bash/powerline.sh
fi
