if [ -f ~/.dotfiles.local ]; then
	. ~/.dotfiles.local
fi

if [ -z "$DOTFILES_HOME" ]; then
	export DOTFILES_HOME="$HOME/.dotfiles"
fi

source_dotfiles_pattern() {
	local folder="$DOTFILES_HOME/$2"
	local pattern="$1"
	for file in $(find -H "$folder" -maxdepth 2 -name "$pattern" -not -path '*/.git/**' -not -path "$folder/if/**")
	do
		source $file
	done
}

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
