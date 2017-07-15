if [ -f ~/.dotfiles.local ]; then
	. ~/.dotfiles.local
fi

if [ -z "$DOTFILES_HOME" ]; then
	export DOTFILES_HOME="$HOME/.dotfiles"
fi

# Load source dotfiles function
. $DOTFILES_HOME/script/function/source.sh

if [ -f ~/.exportrc ]; then
	. ~/.exportrc
fi

if [ -f ~/.functionrc ]; then
	. ~/.functionrc
fi

if [ -f ~/.aliasrc ]; then
	. ~/.aliasrc
fi

if hash powerline-daemon 2>/dev/null; then
	powerline-daemon -q
fi

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
