#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Powerline
if [ -f $DOTFILES_HOME/shell/powerline/powerline/bindings/bash/powerline.sh ]; then
	source $DOTFILES_HOME/shell/powerline/powerline/bindings/bash/powerline.sh
fi
