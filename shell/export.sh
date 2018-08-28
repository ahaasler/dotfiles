if [ -d "$HOME/bin" ]; then
	export PATH=$HOME/bin:$PATH
fi
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$DOTFILES_HOME/shell/powerline/scripts
export PATH=$PATH:$DOTFILES_HOME/shell/bin
export TERM=screen-256color
# On login use ascii
[[ "$(ps -o comm= $PPID)" == "login" ]] || [[ "$(tmux display-message -p '#S')" == "login" ]] && export POWERLINE_CONFIG_OVERRIDES="common.default_top_theme=ascii"
