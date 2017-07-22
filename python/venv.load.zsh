# place this after virtualenvwrapper.sh initialization!
autoload -U add-zsh-hook
load-venv() {
	if [ -e "$PWD/.venv" ]; then
		# Check it's a file
		if [ -f "$PWD/.venv" ]; then
			# Check file has content
			if [ -s "$PWD/.venv" ]; then
				workon $(cat $PWD/.venv)
			# File is empty
			else
				workon $(basename $PWD)
			fi
		else
			return
		fi
	fi
}
add-zsh-hook chpwd load-venv
load-venv
