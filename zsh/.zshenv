if ! type source_dotfiles_pattern &>/dev/null || [[ ! -z "${ZSH_FORCE_PROFILE_LOAD}" ]]; then
	emulate sh
	source ~/.profile
	emulate zsh
fi
