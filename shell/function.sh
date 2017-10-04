mkcd() {
	mkdir -p -- "$1" && cd -- "$1"
}

f() {
	file="$1"
	shift
	if [ "$#" = "0" ]; then
		set "."
	fi
	for d in "$@"; do
		find "$d" -iname "*$file*"
		shift
	done
}
