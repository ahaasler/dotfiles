#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If not running in a login shell, source profile
shopt -q login_shell || source ~/.profile

# Start tmux if conditions are met
source $DOTFILES_HOME/tmux/start.sh

# Use leftonly theme for powerline
export POWERLINE_CONFIG_OVERRIDES=ext.shell.theme=default_leftonly

PS1='[\u@\h \W]\$ '

# Powerline
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
	source /usr/share/powerline/bindings/bash/powerline.sh
fi

source_dotfiles_pattern '*.bash'
# Source distro specific bash config
if [ "$DISTRO" ] && [ -d "$DOTFILES_HOME/if/distro/$DISTRO" ]; then
	source_dotfiles_pattern '*.bash' "if/distro/$DISTRO/"
fi
# Source distro specific  config
if [ "$(hostname)" ] && [ -d "$DOTFILES_HOME/if/hostname/$(hostname)" ]; then
	source_dotfiles_pattern '*.bash' "if/hostname/$(hostname)/"
fi
