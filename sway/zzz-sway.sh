if [[ "$(tty)" == '/dev/tty1' ]]; then
	hash sway 2>/dev/null || return
	printf '\nStarting Sway!\n\n'
	printf '   \e[1;39m                        \e[0;36m _ \e[0m\n'
	printf '   \e[1;39m _____      ____ _ _   _\e[0;36m| |\e[0m\n'
	printf '   \e[1;39m/ __\\ \\ /\\ / / _` | | | \e[0;36m| |\e[0m\n'
	printf '   \e[1;39m\\__ \\\\ V  V / (_| | |_| \e[0;36m|_|\e[0m\n'
	printf '   \e[1;39m|___/ \\_/\\_/ \\__,_|\\__, \e[0;36m(_)\e[0m\n'
	printf '   \e[1;39m                   |___/   \e[0m\n\n'
	ASDF_DISABLE=true
	case $SHELL in
		*/bash) if [ -f $HOME/.profile ]; then . $HOME/.profile; fi ;;
		*/zsh) [ -f $HOME/.zprofile ] && ZSH_FORCE_PROFILE_LOAD=true . $HOME/.zprofile ;;
		*) [ -f $HOME/.profile ] && . $HOME/.profile ;;
	esac
	unset ASDF_DISABLE
	export POWERLINE_CONFIG_OVERRIDES=""
	export XDG_CURRENT_DESKTOP=sway
	export MOZ_ENABLE_WAYLAND=1
	export WLR_NO_HARDWARE_CURSORS=1
	exec sway 2> /tmp/sway.log
fi
