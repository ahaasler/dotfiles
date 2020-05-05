export PATH=$HOME/.local/bin:$PATH
export TERM=screen-256color
# On login use ascii
[[ "$(ps -o comm= $PPID)" == "login" ]] || [[ "$(hash tmux 2> /dev/null && tmux display-message -p '#S')" == "login" ]] && export POWERLINE_CONFIG_OVERRIDES="common.default_top_theme=ascii"
