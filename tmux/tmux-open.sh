name="$(echo "$1" | tr -d '\n')"
if hash tmux 2>/dev/null; then
	tmux a -t "$name" || exec tmux new -s "$name" && exit
fi
