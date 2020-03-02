if hash tmux 2>/dev/null; then
	tmux a -t "$1" || exec tmux new -s "$1" && exit
fi
