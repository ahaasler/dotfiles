if command -v python >& /dev/null; then
	export DISTRO=$(python $DOTFILES_HOME/if/distro/id.py)
fi
