if hash tmux 2>/dev/null; then
	PNAME="$(ps -o comm= $PPID)"
	[[ "$PNAME" == "login" ]] || [[ "$PNAME" == "sshd" ]] || [[ "$PNAME" == "terminator" ]] || [[ "$PNAME" == "gjs" ]] && { tmux a -t "$PNAME" || exec tmux new -s "$PNAME" && exit; }
fi
