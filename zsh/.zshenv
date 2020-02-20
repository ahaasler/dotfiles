if ! type source_dotfiles_pattern &>/dev/null; then
	emulate sh
	source ~/.profile
	emulate zsh
fi
