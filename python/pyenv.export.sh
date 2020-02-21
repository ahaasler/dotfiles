export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if hash pyenv 2>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi
