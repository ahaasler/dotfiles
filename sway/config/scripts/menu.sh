if hash sgtk-grid 2>/dev/null; then
	sgtk-grid -t 60 -b 28 -o 0.8 -f -d 0
elif hash kitty 2>/dev/null; then
	TERMINAL_COMMAND="kitty" kitty --class app-menu -e ~/.config/sway/sway-launcher-desktop.sh
elif hash termite 2>/dev/null; then
	TERMINAL_COMMAND="termite -e" termite --name app-menu -e ~/.config/sway/sway-launcher-desktop.sh
elif hash mako 2>/dev/null; then
	notify-send 'No application to display menu' 'Please, install sgtk-menu, kitty or termite'
elif hash swaynag 2>/dev/null; then
	swaynag -m 'No application to display menu. Please, install sgtk-menu, kitty or termite'
fi
