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
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
	source /usr/share/powerline/bindings/bash/powerline.sh
fi
