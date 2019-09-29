if [[ "$(tty)" == '/dev/tty1' ]]; then
	hash sway 2>/dev/null || return
	printf '\nStarting Sway!\n\n'
	printf '   \e[1;39m                        \e[0;36m _ \e[0m\n'
	printf '   \e[1;39m _____      ____ _ _   _\e[0;36m| |\e[0m\n'
	printf '   \e[1;39m/ __\\ \\ /\\ / / _` | | | \e[0;36m| |\e[0m\n'
	printf '   \e[1;39m\\__ \\\\ V  V / (_| | |_| \e[0;36m|_|\e[0m\n'
	printf '   \e[1;39m|___/ \\_/\\_/ \\__,_|\\__, \e[0;36m(_)\e[0m\n'
	printf '   \e[1;39m                   |___/   \e[0m\n\n'
	case $SHELL in
		*/bash) if [ -f $HOME/.profile ]; then . $HOME/.profile; fi ;;
		*/zsh) [ -f $HOME/.zprofile ] && . $HOME/.zprofile ;;
		*) [ -f $HOME/.profile ] && . $HOME/.profile ;;
	esac
	export POWERLINE_CONFIG_OVERRIDES=""
	exec sway 2> /tmp/sway.log
fi
