if hash wofi 2>/dev/null; then
	wofi --dmenu --allow-images --insensitive --prompt "${1}"
elif hash kitty 2>/dev/null; then
	fzf-kitty -i --reverse --prompt "'${1}: '"
elif hash mako 2>/dev/null; then
	notify-send 'No application to display menu' 'Please, install wofi or kitty'
elif hash swaynag 2>/dev/null; then
	swaynag -m 'No application to display menu. Please, install wofi or kitty'
fi
