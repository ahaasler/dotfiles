if [[ "$(tty)" == '/dev/tty1' ]]; then
	hash sway 2>/dev/null || return
	echo "Starting Sway!"
	case $SHELL in
		*/bash) if [ -f $HOME/.profile ]; then . $HOME/.profile; fi ;;
		*/zsh) [ -f $HOME/.zprofile ] && . $HOME/.zprofile ;;
		*) [ -f $HOME/.profile ] && . $HOME/.profile ;;
	esac
	exec sway 2> /tmp/sway.log
fi
