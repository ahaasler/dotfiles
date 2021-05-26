if hash ulauncher 2>/dev/null; then
	ulauncher-text "tmux "
else
	tmux list-session -F\#S | ~/.config/sway/scripts/menu.sh "Pick tmux session" | xargs -0 -I '%' $term ~/.dotfiles.home/tmux/tmux-open.sh "%"
fi
