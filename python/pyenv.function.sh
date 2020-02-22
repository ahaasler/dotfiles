workon() {
	if [ $# -eq 0 ]; then pyenv virtualenvs --skip-aliases --bare; else pyenv activate $1; fi
}
