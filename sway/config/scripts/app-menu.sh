#!/usr/bin/env bash
RESULT=1
if [ $RESULT -ne 0 ] && hash ulauncher 2>/dev/null; then
	dbus-send \
		--session \
		--print-reply \
		--dest=net.launchpad.ulauncher \
		/net/launchpad/ulauncher \
		net.launchpad.ulauncher.toggle_window
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash wofi 2>/dev/null; then
	wofi --show drun --allow-images --insensitive --prompt "Applications"
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash sgtk-grid 2>/dev/null; then
	sgtk-grid -t 60 -b 28 -o 0.8 -f
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash kitty 2>/dev/null; then
	TERMINAL_COMMAND="kitty" kitty --class app-menu -e ~/.config/sway/sway-launcher-desktop.sh
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash termite 2>/dev/null; then
	TERMINAL_COMMAND="termite -e" termite --name app-menu -e ~/.config/sway/sway-launcher-desktop.sh
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash mako 2>/dev/null; then
	notify-send 'No application to display menu' 'Please, install sgtk-menu, kitty or termite'
	RESULT=$?
fi
if [ $RESULT -ne 0 ] && hash swaynag 2>/dev/null; then
	swaynag -m 'No application to display menu. Please, install sgtk-menu, kitty or termite'
fi
