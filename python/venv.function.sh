function is_python_version() {
	is_python_version_installed $1 || is_python_version_available $1
}

function is_python_version_installed() {
	asdf list python &> /dev/null | grep -e "^ *$1 *$" &> /dev/null
}

function is_python_version_available() {
	asdf list all python &> /dev/null | grep -e "^ *$1 *\$" &> /dev/null
}

function venv() {
	if [ "$#" -ge 1 ]; then
		if is_python_version "$1" &> /dev/null; then
			local python_version="$1"
		else
			local venv_name="$1"
		fi
	fi
	if [ "$#" -ge 2 ]; then
		if [ -z "$python_version" ] && is_python_version "$2" &> /dev/null; then
			local python_version="$2"
		else
			local venv_name="$2"
		fi
	fi
	if [ -z "$venv_name" ]; then
		# Use current folder name as venv name if not specified
		local venv_name="$(basename $PWD)"
	fi
	if [ -n "$python_version" ]; then
		# Install python version with asdf if not installed
		is_python_version_installed "$python_version" || asdf install python "$python_version"
		# Use asdf installed python version
		local python_bin="$ASDF_DATA_DIR/installs/python/$python_version/bin/python"
	else
		# Use asdf configured python version
		local python_bin=$(asdf which python)
	fi
	echo "Creating venv $venv_name with $("$python_bin" --version) ($python_bin)"
	# Create venv
	"$python_bin" -m venv ~/.local/share/venvs/"$venv_name"
	# Activate venv
	source ~/.local/share/venvs/"$venv_name"/bin/activate
}

function venvs() {
	(cd ~/.local/share/venvs/; ls -d *)
}

function venva() {
	if [ -z "$1" ]; then
		source ~/.local/share/venvs/"$(basename $PWD)"/bin/activate
	else
		source ~/.local/share/venvs/"$1"/bin/activate
	fi
}

function workon() {
	if [ $# -eq 0 ]; then venvs; else venva "$1"; fi
}

function venvdel() {
	if [ "$(basename "$VIRTUAL_ENV")" = "$1" ]; then deactivate; fi
	rm -rf ~/.local/share/venvs/"$1"
}
