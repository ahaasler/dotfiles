export WORKON_HOME="$HOME/.virtualenvs"
export PIP_VIRTUALENV_BASE="$WORKON_HOME"
export PIP_RESPECT_VIRTUALENV=true

if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then
	source $HOME/.local/bin/virtualenvwrapper.sh
fi
