# Start tmux if conditions are met
emulate sh
source $DOTFILES_HOME/tmux/start.sh
emulate zsh

# Powerline
if [[ -r $DOTFILES_HOME/shell/powerline/powerline/bindings/zsh/powerline.zsh ]]; then
	source $DOTFILES_HOME/shell/powerline/powerline/bindings/zsh/powerline.zsh
fi

fpath=($DOTFILES_HOME/zsh/zsh-completions/src $fpath)
source $DOTFILES_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $DOTFILES_HOME/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
