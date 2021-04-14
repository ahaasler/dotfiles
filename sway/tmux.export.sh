if [ -n "$TMUX" ]; then
	export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
fi
